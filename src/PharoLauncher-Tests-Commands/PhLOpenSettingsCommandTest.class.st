Class {
	#name : #PhLOpenSettingsCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'settingsBrowser'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLOpenSettingsCommandTest >> tearDown [ 
	settingsBrowser ifNotNil: [ settingsBrowser close ]
]

{ #category : #tests }
PhLOpenSettingsCommandTest >> testCanOpenAboutDialog [
	settingsBrowser := PhLOpenSettingsCommand new execute.

	self assert: (settingsBrowser model isKindOf: PhLSettingBrowser)
]
