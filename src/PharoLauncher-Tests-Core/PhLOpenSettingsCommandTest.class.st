Class {
	#name : 'PhLOpenSettingsCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'settingsBrowser'
	],
	#category : 'PharoLauncher-Tests-Core-Move-From-Commands',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'Move-From-Commands'
}

{ #category : 'running' }
PhLOpenSettingsCommandTest >> tearDown [
	settingsBrowser ifNotNil: [ settingsBrowser close ].
	super tearDown
]

{ #category : 'tests' }
PhLOpenSettingsCommandTest >> testCanOpenSettingsBrowser [
	settingsBrowser := PhLOpenSettingsCommand new execute.

	self assert: (settingsBrowser model isKindOf: PhLSettingBrowser)
]
