"
I represent a Setting Category. I hold some data on the category.
I'm identified by my name. Settinng refer to me by this name.
"
Class {
	#name : 'PhLSettingsGroup',
	#superclass : 'PhLAbstractSetting',
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'private - building' }
PhLSettingsGroup >> asParentWhile: aBlock [

	self builder parent: self while: aBlock
]

{ #category : 'testing' }
PhLSettingsGroup >> hasDefaultValue [

	"Group should manage its visibily. When done, this methods should check the value of the visibility against the default value"
	^ true
]

{ #category : 'accessing' }
PhLSettingsGroup >> realValue [

	"Group should manage its visibily. When done, this methods should return the value of the group visibility"
	^ true
]

{ #category : 'accessing' }
PhLSettingsGroup >> realValue: aValue [

	"Group should manage its visibily. When done, this methods should set the value of the group visibility"
]

{ #category : 'accessing' }
PhLSettingsGroup >> settingReceiver [

	^ self targetSelector
		  ifNil: [ self target ]
		  ifNotNil: [ self target perform: self targetSelector ]
]

{ #category : 'building' }
PhLSettingsGroup >> with: aBlock [

	self asParentWhile: aBlock
]
