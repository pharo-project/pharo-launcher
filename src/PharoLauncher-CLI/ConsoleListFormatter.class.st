"
I represent pretty print formatter that prints to write stream list of domain objects and its attributes.
I am responsible for printing in: 
- table format (default) 
- row mode format - that prints one attribute per line.
- brief mode - prints only one attribute of domain object (name)
- ston format - prints domain object information in STON format. 

I collaborate with cli command instance (PHlCliCommand) that sets variables I use.
API description: 
- rowMode - flag to print of one attribute per line (obtained from cliCommand)
- briefMode - flag to print one attribute only (obtained from cliCommand)
- delimiter - one or more characters that delimits printed attributes of domain object (obtained from cliCommand)
- outputAsSton - flag to print domain object in STON format (obtained from cliCommand)
- printSequence - flag to print sequence order number of domain objects (not implemented yet)
- on (class): constructor that is instantiated from cli command, sets above attributes from command
- domainObjects: setter for domain objects that will be printed on output stream
   - each domain object is printed based on 2 methods (can be bypassed and set user specific): 
     - attributeLabels - array of string labels obtained from cli comamnd, 
     - attributeValueBlocks - array of blocks with one parameter, value of block returns string
- printList - prints listed objects to stream based on flags set
"
Class {
	#name : #ConsoleListFormatter,
	#superclass : #Object,
	#instVars : [
		'briefPrint',
		'cliCommand',
		'delimiter',
		'domainObjects',
		'attributeLabels',
		'attributeValueBlocks',
		'outStream',
		'outputAsSton',
		'printSequence',
		'rowMode',
		'defaultValue'
	],
	#category : #'PharoLauncher-CLI-Utility'
}

{ #category : #'instance creation' }
ConsoleListFormatter class >> on: aCliCommand [
	
	"by default - formatter is instantiated from command, 
	 but can be used as standalone using new, but all parameters has to be set explicitly"
	^ self new 
		cliCommand: aCliCommand; 
		yourself 
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> attributeLabels [
	"lazy initialize from command, if not explicitly set before"

	^ attributeLabels
		ifNil: [ attributeLabels := cliCommand listPrintAttributeLabels ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> attributeLabels: aLabels [

	attributeLabels := aLabels
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> attributeValueBlocks [

	^ attributeValueBlocks
		ifNil: [ attributeValueBlocks := cliCommand listPrintAttributeBlocks ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> attributeValueBlocks: aBlocks [

	attributeValueBlocks := aBlocks
]

{ #category : #private }
ConsoleListFormatter >> attributeValuesFrom: aDomainObject [

	^ self attributeValueBlocks collect: [:aBlock | aBlock value: aDomainObject ]

]

{ #category : #'accessing - command' }
ConsoleListFormatter >> briefPrint [

	^ briefPrint ifNil: [ briefPrint := cliCommand briefPrint ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> briefPrint: aBool [

	briefPrint := aBool
]

{ #category : #'accessing - public' }
ConsoleListFormatter >> cliCommand: aCommand [

	cliCommand := aCommand
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> delimiter [ 

	^ delimiter ifNil: [ delimiter := cliCommand delimiter ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> delimiter: aString [ 

	delimiter := aString
]

{ #category : #'accessing - public' }
ConsoleListFormatter >> domainObjects [
 
 ^ domainObjects
]

{ #category : #'accessing - public' }
ConsoleListFormatter >> domainObjects: anObjects [ 

	domainObjects := anObjects.
	defaultValue := nil.
]

{ #category : #'accessing - public' }
ConsoleListFormatter >> domainObjects: someObjects defaultValue: anObject [

	domainObjects := someObjects.
	defaultValue := anObject.
]

{ #category : #private }
ConsoleListFormatter >> getColumnWidthsFrom: someObjects [
	"get max column width either from column label or value in column"
	| labels |
	
	labels := self attributeLabels.
	^ self attributeValueBlocks
		withIndexCollect:
			[ :attrBlock :index | (self getMaxPrintStringWidthFor: someObjects printBlock: attrBlock) max: (labels at: index) size ]
]

{ #category : #private }
ConsoleListFormatter >> getMaxPrintStringWidthFor: someObjects printBlock: printBlock [
	"evaluate print block and obtain string size, return max value from collection"

	^ (someObjects collect: [ :item | (printBlock value: item) size ])
		max
]

{ #category : #testing }
ConsoleListFormatter >> hasDefaultValue [

	^ defaultValue notNil
]

{ #category : #private }
ConsoleListFormatter >> indexColumnDefaultSize [
	^ 2
]

{ #category : #private }
ConsoleListFormatter >> indexColumnSize [
	^ self hasDefaultValue 
		ifTrue: [ self indexColumnDefaultSize + 1 ]
		ifFalse: [ self indexColumnDefaultSize ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> outStream [ 

	^ outStream ifNil: [ outStream := cliCommand outStream ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> outStream: aWriteStream [

	outStream := aWriteStream
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> outputAsSton [ 

	^ outputAsSton ifNil: [outputAsSton := cliCommand outputAsSton]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> outputAsSton: aBoolean [

	outputAsSton := aBoolean
]

{ #category : #private }
ConsoleListFormatter >> printAttributeHeaders: labels by: columnWidths [
	"print header labels and header line"

	"print sequence nr. eventually"
	self printSequence ifTrue: [
		self printCell: '#' width: self indexColumnSize.
		self printDelimiter
	].
	self printRowValues: labels by: columnWidths. 
	self printHeaderLinesBy: columnWidths.
]

{ #category : #private }
ConsoleListFormatter >> printAttributeRows: someObjects by: columnWidths [

	someObjects withIndexDo: [:listedObject :idx|
		self hasDefaultValue ifTrue: [ self printDefaultValueMark: listedObject ].
		self printCell: idx asString width: self indexColumnDefaultSize.
		self printDelimiter.
		self printRowValues: (self attributeValuesFrom: listedObject) by: columnWidths		
	]
]

{ #category : #private }
ConsoleListFormatter >> printAttributeTable [

	| columnWidths |
	columnWidths := self getColumnWidthsFrom: self domainObjects.
	"no header if brief print is enabled"
	self briefPrint 
		ifFalse: [ self printAttributeHeaders: self attributeLabels by: columnWidths ].
	self printAttributeRows: self domainObjects by: columnWidths
]

{ #category : #private }
ConsoleListFormatter >> printCell: aString width: widthSize [

	self outStream nextPutAll: (aString padRightTo: widthSize)

]

{ #category : #private }
ConsoleListFormatter >> printDefaultValueMark: listedObject [

	self outStream nextPut: (listedObject == defaultValue
			 ifTrue: [ $* ]
			 ifFalse: [ Character space ])
]

{ #category : #private }
ConsoleListFormatter >> printDelimiter [

	self outStream nextPutAll: self delimiter
]

{ #category : #private }
ConsoleListFormatter >> printHeaderLinesBy: columnWidths [
	"print header line"

	self printSequence ifTrue: [
		self printLineSized: self indexColumnSize.
		self printDelimiter.
	].
	columnWidths withIndexDo: [:aWidth :idx| self printLineSized: aWidth.
		idx = columnWidths size ifFalse: [ self printDelimiter]].
	self outStream newLine.
]

{ #category : #private }
ConsoleListFormatter >> printLineSized: aWidth [ 

	aWidth timesRepeat: [self outStream nextPut: $-]
]

{ #category : #printing }
ConsoleListFormatter >> printList [

	self outputAsSton
		ifTrue: [ ^ self printListAsSton ].
		
	self printListAttributes
]

{ #category : #printing }
ConsoleListFormatter >> printListAsSton [

	self outStream nextPutAll: (STON toString: self domainObjects) 
]

{ #category : #printing }
ConsoleListFormatter >> printListAttributes [
	self domainObjects isEmptyOrNil
		ifTrue: [ ^ self ].
		
	self rowMode
		ifTrue: [ self printOneAttrPerRow ]
		ifFalse: [ self printAttributeTable ]
]

{ #category : #private }
ConsoleListFormatter >> printOneAttrPerRow [
	| blockArray aLabels |
	
	blockArray := self attributeValueBlocks.
	aLabels := self attributeLabels.
	self domainObjects withIndexDo: [ :listedObject :idx | 
		self printSequence
			ifTrue: [ self printRowValues: {'Nr.'. idx asString} by: {0 . 2} ].
		aLabels withIndexDo: [ :attrLabel :attrIdx | 
			self printRowValues: {attrLabel. ((blockArray at: attrIdx) value: listedObject)} by: {0 . 0} ].
		self outStream newLine ]
]

{ #category : #private }
ConsoleListFormatter >> printRowValues: values by: columnWidths [

	values withIndexDo: [:aLabel :idx |
		self printCell: aLabel width: (columnWidths at: idx).
		idx = values size ifFalse: [ self printDelimiter].
	].
	self outStream newLine.
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> printSequence [ 

	^ printSequence ifNil: [ printSequence := cliCommand printSequence ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> printSequence: aBoolean [

	printSequence := aBoolean 
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> rowMode [ 

	^ rowMode ifNil: [ rowMode := cliCommand rowMode ]
]

{ #category : #'accessing - command' }
ConsoleListFormatter >> rowMode: aBool [

	rowMode := aBool 
]
