Class {
	#name : 'PhLOpenSettingsCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'settingsBrowser'
	],
	#category : 'PharoLauncher-Tests-Core-not-faulty',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'not-faulty'
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
