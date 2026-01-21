Class {
	#name : 'PhLOpenSettingsCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'settingsFile',
		'settings',
		'settingsPresenter'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLOpenSettingsCommandTest >> application [ 

	^ PhLTestApplication new
]

{ #category : 'running' }
PhLOpenSettingsCommandTest >> setUp [ 

	super setUp.
	settingsFile := FileSystem memory root / 'settings.ston'.
	settings := PharoLauncherSettings new
		preferencesFile: settingsFile;
		yourself.

]

{ #category : 'running' }
PhLOpenSettingsCommandTest >> tearDown [
	settingsPresenter ifNotNil: [ settingsPresenter close ].
	super tearDown
]

{ #category : 'tests' }
PhLOpenSettingsCommandTest >> testCanOpenSettingsBrowser [
	PharoLauncherSettings
		default: settings
		during: [ settingsPresenter := PhLOpenSettingsCommand new
		                                context: self;
		                                execute ].

	self assert: (settingsPresenter presenter isKindOf: PhLSettingsPresenter)
]
