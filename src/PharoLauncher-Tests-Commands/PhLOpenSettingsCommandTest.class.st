Class {
	#name : 'PhLOpenSettingsCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'settingsBrowser'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLOpenSettingsCommandTest >> application [ 

	^ PhLTestApplication new
]

{ #category : 'running' }
PhLOpenSettingsCommandTest >> tearDown [
	settingsBrowser ifNotNil: [ settingsBrowser close ].
	super tearDown
]

{ #category : 'tests' }
PhLOpenSettingsCommandTest >> testCanOpenSettingsBrowser [
	settingsBrowser := PhLOpenSettingsCommand new
		context: self;
		execute.

	self assert: (settingsBrowser presenter isKindOf: PhLSettingsPresenter)
]
