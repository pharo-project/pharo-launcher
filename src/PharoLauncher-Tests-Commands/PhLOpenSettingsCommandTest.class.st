Class {
	#name : 'PhLOpenSettingsCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'settingsBrowser',
		'settingsFile'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'running' }
PhLOpenSettingsCommandTest >> setUp [ 

	super setUp.
	self setUpPharoSettingsTestFile
]

{ #category : 'running' }
PhLOpenSettingsCommandTest >> setUpPharoSettingsTestFile [

	| settingTree persistence |
	settingTree := (PhLSettingBrowser forKeywords: #( #pharoLauncherSettings )) treeHolder.

	settingsFile := FileSystem memory / 'settings.ston'.
	persistence := SystemSettingsPersistence new
		               fileReference: settingsFile;
		               settingTree: settingTree;
		               yourself.
		
	"Generate the settings file wihtout developmentEnvironmentEnabled setting that could trigger actions on the current image"
	persistence storeSettingNodes:
		(settingTree nodeList reject: [ :node |
			 node settingNodeIdentifier = '#pharoLauncher#developmentEnvironmentEnabled' ])
]

{ #category : 'running' }
PhLOpenSettingsCommandTest >> tearDown [
	settingsBrowser ifNotNil: [ settingsBrowser close ].
	super tearDown
]

{ #category : 'tests' }
PhLOpenSettingsCommandTest >> testCanOpenSettingsBrowser [

	PhLSettingBrowser
		usePreferencesFile: settingsFile
		during: [ settingsBrowser := PhLOpenSettingsCommand new execute ].

	self assert: (settingsBrowser model isKindOf: PhLSettingBrowser)
]
