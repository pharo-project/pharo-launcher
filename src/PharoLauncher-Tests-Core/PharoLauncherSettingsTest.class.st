Class {
	#name : 'PharoLauncherSettingsTest',
	#superclass : 'TestCase',
	#instVars : [
		'settings',
		'settingsBackup'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'running' }
PharoLauncherSettingsTest >> setUp [
	super setUp.
	settings := PharoLauncherSettings new.
	settingsBackup := settings names 
		collect: [ :id | id -> (settings valueOfSettingNamed: id) ]
]

{ #category : 'running' }
PharoLauncherSettingsTest >> tearDown [

	settingsBackup do: [ :association |
			settings
				setValueOfSettingNamed: association key
				with: association value ].
	super tearDown
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanStoreSettings [

	| stonString expextedSettingSerialization settingsFile |
	
	settingsFile := FileSystem memory root / 'settings.ston'.
	settings manager settingsFile: settingsFile.
	expextedSettingSerialization := '	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#launchInALoginShell'',
		#realValue : true
	}'.
	
	settings store.
	
	stonString := settingsFile contents.
	self 
		assert: (stonString withInternetLineEndings beginsWith: '[', String cr)
		description: 'Serialization is not an array: ', stonString withInternetLineEndings.
	self 
		assert: (stonString withInternetLineEndings includesSubstring: expextedSettingSerialization withInternetLineEndings)
		description: 'Setting node serialization is not the one expected:', stonString withInternetLineEndings
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testChangeInASettingTriggerSettingsSaving [

	| settingsFile presenter storedSettings launchInALoginShellSetting |
	
	settingsFile := FileSystem memory root / 'settings.ston'.
	settings manager settingsFile: settingsFile.
	presenter := PhLGeneralSettingsPresenter on: settings.
	
	self assert: PhLDefaultLaunchConfiguration launchInALoginShell equals: true.
	presenter launchInALoginShell: false.
	
	self deny: PhLDefaultLaunchConfiguration launchInALoginShell.
	storedSettings := settings manager allStoredSettings.
	launchInALoginShellSetting := storedSettings detect: [ :storedSetting | storedSetting settingNodeIdentifier = '#pharoLauncher#launchInALoginShell' ].
	self assert: launchInALoginShellSetting realValue equals: false
	
	
]
