"
A Setting is an handler for a setting value.
It holds descriptive data about the setting.
"
Class {
	#name : 'PhLSetting',
	#superclass : 'PhLAbstractSetting',
	#instVars : [
		'getSelector',
		'setSelector',
		'readBlock',
		'writeBlock',
		'precondition'
	],
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'accessing' }
PhLSetting class >> validTypes [

	^ #( #string #boolean #integer #float #file )
]

{ #category : 'old setting builder - with support on setting' }
PhLSetting >> asParentWhile: aBlock [

	self builder parent: self while: aBlock
]

{ #category : 'private' }
PhLSetting >> basicRealValue [

	^ readBlock 
		ifNil: [ self settingReceiver perform: self getSelector ]
		ifNotNil: [ readBlock value ]
]

{ #category : 'old setting builder compatibility' }
PhLSetting >> default: aValue [

	self 
		deprecated: 'Use #defaultValue: instead. #Pharo14'
		transformWith: '`@receiver default: `@aValue' -> '`@receiver defaultValue: `@aValue'.
	self defaultValue: aValue
]

{ #category : 'accessing' }
PhLSetting >> defaultTarget [

	"Return the class where the setting was defined"
	^ self declaration methodClass instanceSide
]

{ #category : 'accessing' }
PhLSetting >> getSelector [

	^ getSelector ifNil: [ self name ]
]

{ #category : 'accessing' }
PhLSetting >> getSelector: aSymbol [

	getSelector := aSymbol
]

{ #category : 'old setting builder compatibility' }
PhLSetting >> ghostHelp: aString [

	self flag: 'ToDo'
]

{ #category : 'testing' }
PhLSetting >> hasGroup [
	
	^ group isNotNil
]

{ #category : 'testing' }
PhLSetting >> hasTarget [
	
	^ target isNotNil
]

{ #category : 'accessing' }
PhLSetting >> precondition: aValuable [

	precondition := aValuable
]

{ #category : 'accessing' }
PhLSetting >> readBlock: aBlock [

	readBlock := aBlock 
]

{ #category : 'accessing' }
PhLSetting >> realTarget [

	(self hasTarget not and: [ self hasGroup not ]) 
		ifTrue: [ ^ self defaultTarget ].

	^ target isSymbol
		  ifTrue: [ Smalltalk globals at: target ifAbsent: [ ] ]
		  ifFalse: [ target ]
]

{ #category : 'accessing' }
PhLSetting >> realValue [

	^ self basicRealValue ifNil: [
			  self setToDefault.
			  self basicRealValue ]
]

{ #category : 'accessing' }
PhLSetting >> realValue: anObject [

	^ writeBlock 
		ifNil: [ self settingReceiver perform: self setSelector with: anObject ]
		ifNotNil: [ writeBlock value: anObject ]
]

{ #category : 'accessing' }
PhLSetting >> selector: aSymbol [

	self getSelector: aSymbol.
	self setSelector: aSymbol asMutator
]

{ #category : 'accessing' }
PhLSetting >> setSelector [

	^ setSelector ifNil: [
		  self getSelector ifNotNil: [ :selector | (selector , ':') asSymbol ] ]
]

{ #category : 'accessing' }
PhLSetting >> setSelector: aSymbol [

	setSelector := aSymbol
]

{ #category : 'setting' }
PhLSetting >> setToDefault [

	self realValue: self defaultValue
]

{ #category : 'accessing' }
PhLSetting >> settingReceiver [

	(self hasTarget not and: [ self hasGroup ])
		ifTrue: [ ^ self group settingReceiver ifNil: [ self defaultTarget ] ].

	^ self targetSelector
		  ifNil: [ self realTarget ]
		  ifNotNil: [ self realTarget perform: self targetSelector ]
]

{ #category : 'accessing' }
PhLSetting >> type [

	^ type
]

{ #category : 'accessing' }
PhLSetting >> type: aSymbol [

	(self class validTypes includes: aSymbol)
		ifTrue: [ type := aSymbol ]
		ifFalse: [ PhLUnknownSettingType signalType: aSymbol ]
]

{ #category : 'old setting builder - with support on setting' }
PhLSetting >> with: aBlock [

	self asParentWhile: aBlock
]

{ #category : 'accessing' }
PhLSetting >> writeBlock: aBlock [

	writeBlock := aBlock 
]
