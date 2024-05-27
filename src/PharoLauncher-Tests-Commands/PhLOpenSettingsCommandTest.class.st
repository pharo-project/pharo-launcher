Class {
	#name : 'PhLOpenSettingsCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'settingsBrowser'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
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
