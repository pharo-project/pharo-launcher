Class {
	#name : 'AttributeListPrintingTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-CLI-Tests-Others',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Others'
}

{ #category : 'tests - attribute labels' }
AttributeListPrintingTest >> testCanPrintAttributeLabelsOfALocalTemplate [

	self assert: (PhLLocalTemplate listPrintAttributeLabels allSatisfy: #isString)
]

{ #category : 'tests - attribute labels' }
AttributeListPrintingTest >> testCanPrintAttributeLabelsOfATemplate [

	self assert: (PhLRemoteTemplate listPrintAttributeLabels allSatisfy: #isString)
]

{ #category : 'tests - attribute labels' }
AttributeListPrintingTest >> testCanPrintAttributeLabelsOfATemplateGroup [

	self assert: (PhLCacheTemplateGroup listPrintAttributeLabels allSatisfy: #isString)
]

{ #category : 'tests - attribute labels' }
AttributeListPrintingTest >> testCanPrintAttributeLabelsOfAVirtualMachine [

	self assert: (PhLVirtualMachine listPrintAttributeLabels allSatisfy: #isString)
]

{ #category : 'tests - attribute labels' }
AttributeListPrintingTest >> testCanPrintAttributeLabelsOfAnImage [

	| image |
	image := PhLImageMock atRandom. 
	self assert: (image class listPrintAttributeLabels allSatisfy: #isString).
]

{ #category : 'tests - attributes' }
AttributeListPrintingTest >> testCanPrintAttributesOfALocalTemplate [

	|blocks aTemplate| 
	aTemplate := PhLLocalTemplate name: 'Test' zipFile: FileSystem memory root / 'Test.zip'.
	blocks := aTemplate class listPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: aTemplate ]) allSatisfy: #isString).
]

{ #category : 'tests - attributes' }
AttributeListPrintingTest >> testCanPrintAttributesOfATemplate [

	|blocks aTemplate| 
	aTemplate := PhLRemoteTemplate name: 'Test' url: 'http://foo.example.com/Test.zip'.
	blocks := aTemplate class listPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: aTemplate ]) allSatisfy: #isString).
]

{ #category : 'tests - attributes' }
AttributeListPrintingTest >> testCanPrintAttributesOfATemplateGroup [

	|categories printedElements |
	categories := PhLTemplateGroupRepository default roots.
	printedElements := categories flatCollect: [ :cat | cat class listPrintAttributeBlocks collect: [ :block | block value: cat ] ].
	self assert: (printedElements allSatisfy: #isString).
]

{ #category : 'tests - attributes' }
AttributeListPrintingTest >> testCanPrintAttributesOfAVirtualMachine [

	|blocks vm| 
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '80-x64';
		yourself.
	blocks := vm class listPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: vm ]) allSatisfy: #isString).
]

{ #category : 'tests - attributes' }
AttributeListPrintingTest >> testCanPrintAttributesOfAnImage [

	| blocks image |
	image := PhLImageMock atRandom. 
	blocks := image class listPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: image ]) allSatisfy: #isString).
]

{ #category : 'tests - attribute labels' }
AttributeListPrintingTest >> testCanPrintExtendedAttributeLabelsOfAnImage [

	| image |
	image := PhLImageMock atRandom. 
	self assert: (image class extendedListPrintAttributeLabels allSatisfy: #isString).
]

{ #category : 'tests - attributes' }
AttributeListPrintingTest >> testCanPrintExtendedAttributesOfAnImage [

	| image blocks | 
	image := PhLImageMock atRandom. 
	blocks := image class extendedListPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: image ]) allSatisfy: #isString).
]

{ #category : 'tests - attribute labels' }
AttributeListPrintingTest >> testCannotPrintAttributeLabelsOfACommand [

	| aCommand |
	aCommand := (PhLCliCommand asCliCommand activationWith: #('launcher' )) command.
	
	"should be empty by on launcher class"
	self assert: aCommand listPrintAttributeLabels isEmpty
]

{ #category : 'tests - attributes' }
AttributeListPrintingTest >> testCannotPrintAttributesOfACommand [

	| aCommand |
	aCommand := (PhLCliCommand asCliCommand activationWith: #('launcher' )) command.
	
	"should be empty by on launcher class"
	self assert: aCommand listPrintAttributeBlocks isEmpty
]
