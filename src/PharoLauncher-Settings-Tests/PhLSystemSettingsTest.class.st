Class {
	#name : 'PhLSystemSettingsTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Settings-Tests',
	#package : 'PharoLauncher-Settings-Tests'
}

{ #category : 'building' }
PhLSystemSettingsTest >> systemSettings [

	^ (SettingsBuilder forPragmaNamed: #systemsettings) settings
]

{ #category : 'tests' }
PhLSystemSettingsTest >> testCanAccessAllSettingsRealValues [

	self systemSettings do: [ :eachSetting |
		eachSetting hasDefaultValue and: [ eachSetting realValue ] ]
]

{ #category : 'tests' }
PhLSystemSettingsTest >> testUniqueIdentifiers [

	| identifiers |
	identifiers := self systemSettings collect: [ :each | each settingIdentifier ].
	
	self assert: identifiers size equals: identifiers asSet size
]

{ #category : 'tests' }
PhLSystemSettingsTest >> testUniqueNames [

	| names |
	names := self systemSettings collect: [ :eachSetting |
						eachSetting groupName printString, eachSetting name ].
					
	self assert: names size equals: names asSet size
]
