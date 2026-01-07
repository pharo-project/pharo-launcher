"
I factor common slots between a Setting and a Setting Category.
"
Class {
	#name : 'PhLAbstractSetting',
	#superclass : 'Object',
	#instVars : [
		'name',
		'label',
		'description',
		'order',
		'groupName',
		'group',
		'target',
		'targetSelector',
		'defaultValue',
		'declaration'
	],
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'comparing' }
PhLAbstractSetting >> = other [

	^ self species = other species 
		and: [ self name = other name ]
]

{ #category : 'visiting' }
PhLAbstractSetting >> acceptSettings: aVisitor [
	^ aVisitor visitSettingDeclaration: self
]

{ #category : 'private' }
PhLAbstractSetting >> builder [

	^ ActiveSettingBuilder value
]

{ #category : 'accessing' }
PhLAbstractSetting >> declaration [
	
	^ declaration
]

{ #category : 'accessing' }
PhLAbstractSetting >> declaration: aPragma [
	
	declaration := aPragma
]

{ #category : 'accessing' }
PhLAbstractSetting >> defaultValue [

	^ defaultValue
]

{ #category : 'accessing' }
PhLAbstractSetting >> defaultValue: aValue [

	defaultValue := aValue
]

{ #category : 'accessing' }
PhLAbstractSetting >> description [
	"Answer the value of description"

	^ description
		ifNil: [ '' ]
		ifNotNil: [ description translated ]
]

{ #category : 'accessing' }
PhLAbstractSetting >> description: aString [

	description := aString
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> dialog: anObject [

	self flag: 'What does mean a dialog for a group?'.
]

{ #category : 'accessing' }
PhLAbstractSetting >> group [

	^ group
]

{ #category : 'accessing' }
PhLAbstractSetting >> group: aSetting [

	group := aSetting
]

{ #category : 'accessing' }
PhLAbstractSetting >> groupName [
	
	^ groupName
]

{ #category : 'accessing' }
PhLAbstractSetting >> groupName: aSymbol [
	
	groupName := aSymbol
]

{ #category : 'testing' }
PhLAbstractSetting >> hasDefaultValue [

	^ self realValue = self defaultValue
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> hasValue [

	^ true
]

{ #category : 'comparing' }
PhLAbstractSetting >> hash [

	^ self species hash bitXor: self name hash
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> iconName: aString [

	self flag: 'ToDo'
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> item [

	self 
		deprecated: 'Use self instead. #Pharo14'
		transformWith: '`@receiver item' -> '`@receiver'.
		
	^ self
]

{ #category : 'accessing' }
PhLAbstractSetting >> label [

	^ label
		  ifNil: [ self name translated ]
		  ifNotNil: [ label translated ]
]

{ #category : 'accessing' }
PhLAbstractSetting >> label: aString [

	label := aString
]

{ #category : 'accessing' }
PhLAbstractSetting >> name [

	^ name 
		ifNil: [ 'Unnamed ' , self class name ] 
		ifNotNil: [ name ]
]

{ #category : 'accessing' }
PhLAbstractSetting >> name: aName [

	name := aName asSymbol
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> noOrdering [

	self flag: 'ToDo'
]

{ #category : 'accessing' }
PhLAbstractSetting >> order [

	^ order
]

{ #category : 'accessing' }
PhLAbstractSetting >> order: aNumber [

	order := aNumber
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> parent: aSymbol [
	
	self 
		deprecated: 'Use #groupName: instead. #Pharo14'
		transformWith: '`@receiver parent: `@aSymbol' -> '`@receiver groupName: `@aSymbol'.

	self groupName: aSymbol
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> parentName: aSymbol [
	
	self 
		deprecated: 'Use #groupName: instead. #Pharo14'
		transformWith: '`@receiver parent: `@aSymbol' -> '`@receiver groupName: `@aSymbol'.

	self groupName: aSymbol
]

{ #category : 'printing' }
PhLAbstractSetting >> printOn: aStream [

	aStream
		<< '['
		<< self className
		<< ': ';
		<< self name asString;
		<< ']'
]

{ #category : 'accessing' }
PhLAbstractSetting >> settingIdentifier [
	
	^ String streamContents: [ :aStream |
			self settingIdentifierOn: aStream ]
]

{ #category : 'printing' }
PhLAbstractSetting >> settingIdentifierOn: aWriteStream [ 

	group
		ifNotNil: [ group settingIdentifierOn: aWriteStream ]
		ifNil: [ groupName ifNotNil: [ aWriteStream print: groupName ] ].
	aWriteStream print: self name
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> settingNodeIdentifier [
	
	self 
		deprecated: 'Use #defaultValue: instead. #Pharo14'
		transformWith: '`@receiver settingNodeIdentifier' -> '`@receiver settingIdentifier'.
]

{ #category : 'old setting builder compatibility' }
PhLAbstractSetting >> settingNodeIdentifierOn: aWriteStream [ 

	self 
		deprecated: 'Use #settingIdentifierOn: instead. #Pharo14'
		transformWith: '`@receiver settingNodeIdentifierOn: `@aWriteStream' -> '`@receiver settingIdentifierOn: `@aWriteStream'
]

{ #category : 'accessing' }
PhLAbstractSetting >> target [

	^ target
]

{ #category : 'accessing' }
PhLAbstractSetting >> target: anObject [

	target := anObject
]

{ #category : 'accessing' }
PhLAbstractSetting >> targetSelector [

	^ targetSelector
]

{ #category : 'accessing' }
PhLAbstractSetting >> targetSelector: aSelector [

	targetSelector := aSelector
]
