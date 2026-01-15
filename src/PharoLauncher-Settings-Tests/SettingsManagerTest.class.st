"
A SettingsManagerTest is a test class for testing the behavior of SettingsManager
"
Class {
	#name : 'SettingsManagerTest',
	#superclass : 'TestCase',
	#instVars : [
		'manager',
		'preferencesFile'
	],
	#category : 'PharoLauncher-Settings-Tests',
	#package : 'PharoLauncher-Settings-Tests'
}

{ #category : 'asserting' }
SettingsManagerTest >> assertStoredSettingsDoNotInclude: aIdentifier [

	| settings |
	self assert: preferencesFile exists.

	settings := preferencesFile readStreamDo: [ :stream | STON fromStream: stream ].

	settings detect: [ :aSetting | aSetting settingNodeIdentifier = aIdentifier printString ]
		ifFound: [ :aSetting | self fail: 'The node has been found, it should not be there' ]
		ifNone: [ ^ self ]
]

{ #category : 'running' }
SettingsManagerTest >> setUp [
	super setUp.

	manager := SettingsManager new.
	preferencesFile := FileSystem memory root / 'pharo' / 'pharoX.Y' / 'preferences.ston.txt'.
	manager fileReference: preferencesFile.
]

{ #category : 'test data' }
SettingsManagerTest >> stonStoredSettingsString [

	^ '[
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#launcherCoreDirString'',
		#realValue : ''/Users/me/Documents/Pharo''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#templatesClearedOnStartup'',
		#realValue : false
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#initializationScriptsLocation'',
		#realValue : ''/Users/me/Documents/Pharo/scripts''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#hardResetPersistanceState'',
		#realValue : false
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#quitOnLaunch'',
		#realValue : false
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#warnOnArchMismatch'',
		#realValue : true
	},
	StoredSetting {
		#settingNodeIdentifier : ''#network#useHTTPProxy'',
		#realValue : false
	},
	StoredSetting {
		#settingNodeIdentifier : ''#useHTTPProxy#httpProxyPort'',
		#realValue : 80
	},
	StoredSetting {
		#settingNodeIdentifier : ''#useHTTPProxy#httpProxyServer'',
		#realValue : ''''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#useHTTPProxy#manageHttpProxyExceptions'',
		#realValue : ''''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#network#useNetworkAuthentification'',
		#realValue : false
	},
	StoredSetting {
		#settingNodeIdentifier : ''#useNetworkAuthentification#proxyUser'',
		#realValue : ''''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#useNetworkAuthentification#proxyPassword'',
		#realValue : ''''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#vmStoreString'',
		#realValue : ''/Users/me/Documents/Pharo/vms''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#shouldCheckTemplateSourcesUpdate'',
		#realValue : true
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#locationString'',
		#realValue : ''/Users/me/Documents/Pharo/images''
	},
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#launchInALoginShell'',
		#realValue : true
	},
	StoredSetting {
		#settingNodeIdentifier : ''#canvasScaleFactorGroup#canvasScaleFactor'',
		#realValue : 2
	}
]
'
]

{ #category : 'tests' }
SettingsManagerTest >> testAllStoredSettingsGivesNoSettingWhenNoPreferenceFile [
	"There is no preference file. It should not generate an error."

	manager fileReference: preferencesFile.
	self assertEmpty: manager allStoredSettings.
	
	manager writeStreamDo: [ :stream | stream nextPutAll: 'random string' ].
	
	self assert: manager fileReference contents equals: 'random string'.
	self assertEmpty: manager allStoredSettings
]

{ #category : 'tests - loading' }
SettingsManagerTest >> testCanLoadSettingsFromAFile [

	| storedSettings file |
	file := FileSystem memory root / 'settings.ston'.
	file writeStreamDo: [ :stream | stream nextPutAll: self stonStoredSettingsString ].
	manager fileReference: file.
	
	storedSettings := manager allStoredSettings.
	
	self assert: storedSettings size equals: 18.
	self assert: (storedSettings allSatisfy: [ :each | each class = StoredSetting ])
]

{ #category : 'tests - loading' }
SettingsManagerTest >> testCanLoadSettingsFromAStream [

	| storedSettings |
	manager readStream: self stonStoredSettingsString readStream.
	
	storedSettings := manager allStoredSettings.
	
	self assert: storedSettings size equals: 18.
	self assert: (storedSettings allSatisfy: [ :each | each class = StoredSetting ])
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testCanStoreSettingNodesSequentially [

	| settings storedSettings |
	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	settings := {
		            SettingsTestData booleanSetting.
		            SettingsTestData rangeSetting }.
	settings first target shouldQuit: true.
	settings second target scaleFactor: 2.

	manager storeSetting: settings first.

	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	storedSettings := STON fromString: preferencesFile contents.
	self assert: storedSettings size equals: 1.
	self
		assert: storedSettings first settingNodeIdentifier
		equals: settings first settingIdentifier.

	manager storeSetting: settings second.

	storedSettings := STON fromString: preferencesFile contents.
	self assert: storedSettings size equals: settings size.
	self
		assert: storedSettings first settingNodeIdentifier
		equals: settings first settingIdentifier.
	self
		assert: storedSettings second settingNodeIdentifier
		equals: settings second settingIdentifier
]

{ #category : 'tests - loading' }
SettingsManagerTest >> testCanUpdateSomeSettings [

	| settings settingsToUpdate |
	settings := SettingsTestData settings.
	manager settings: settings.
	(manager settingNamed: #uiThemeClass) realValue: Array.
	(manager settingNamed: #shouldQuit) realValue: true.
	(manager settingNamed: #scaleFactor) realValue: 2.5.
	manager storeSettings.
	(manager settingNamed: #uiThemeClass) realValue: String.
	(manager settingNamed: #shouldQuit) realValue: false.
	(manager settingNamed: #scaleFactor) realValue: 1.
	
	settingsToUpdate := settings reject: [ :setting | setting name = #uiThemeClass ].
	manager updateSettings: settingsToUpdate.
	
	self assert: (manager settingNamed: #shouldQuit) realValue equals: true.
	self assert: (manager settingNamed: #scaleFactor) realValue equals: 2.5.
	"uiThemeClass should not be updated"
	self assert: (manager settingNamed: #uiThemeClass) realValue equals: String
]

{ #category : 'tests - storing - defaults' }
SettingsManagerTest >> testFreshSettingsHaveDefaultValue [

	| nodesToStore |
	"A setting with default value should not be saved.
	The settings should only be saved if changed from default value"
	
	nodesToStore := manager storedSettingsFor:
		                (SettingsTestData settings select: [ :aSetting | aSetting hasDefault ]).

	self assert: (nodesToStore reject: [ :aNode | aNode hasDefaultValue ]) isEmpty
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testSettingNodeIsNotStoredWhenHasDefaultValue [

	| storedSettings setting |
	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	setting :=  { SettingsTestData rangeSetting }.
	setting first target scaleFactor: 1.

	manager storeSettings: setting.
	
	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	storedSettings := STON fromString: preferencesFile contents.
	self assert: storedSettings size equals: 0
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testSettingNodeIsStoredWhenHasNotDefaultValue [

	| storedSettings setting |
	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	setting :=  { SettingsTestData rangeSetting }.
	setting first target scaleFactor: 1.5.

	manager storeSettings: setting.
	
	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	storedSettings := STON fromString: preferencesFile contents.
	self assert: storedSettings size equals: 1.
	self assert: storedSettings first realValue equals: 1.5
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testSettingsNotDuplicatedWhenStoreSettingNodeTwice [

	| setting storedSetting storedNodes |
	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	setting := SettingsTestData booleanSetting.
	setting target shouldQuit: true.

	manager storeSettings: { setting }.
	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	manager storeSettings: { setting }.
	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	storedNodes := STON fromString: preferencesFile contents.
	self assert: storedNodes size equals: 1.
	storedSetting := storedNodes first.
	self
		assert: storedSetting settingNodeIdentifier
		equals: setting settingIdentifier.
	self assert: storedSetting realValue equals: setting realValue
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testStoreIdentifier [

	| setting storedSetting |
	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	setting := SettingsTestData booleanSetting.
	setting target shouldQuit: true.
	manager settings: { setting }.
	
	manager storeIdentifier: setting settingIdentifier.
	
	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	storedSetting := (STON fromString: preferencesFile contents) first.
	self
		assert: storedSetting settingNodeIdentifier
		equals: setting settingIdentifier.
	self assert: storedSetting realValue equals: setting realValue
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testStoreSettingNode [

	| setting storedSetting |
	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	setting := SettingsTestData booleanSetting.
	setting target shouldQuit: true.

	manager storeSettings: { setting }.
	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	storedSetting := (STON fromString: preferencesFile contents) first.
	self
		assert: storedSetting settingNodeIdentifier
		equals: setting settingIdentifier.
	self assert: storedSetting realValue equals: setting realValue
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testStoreSettingNodes [

	| settings storedSettings |
	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	settings := {
		            SettingsTestData booleanSetting.
		            SettingsTestData rangeSetting }.
	settings first target shouldQuit: true.
	settings second target scaleFactor: 2.

	manager storeSettings: settings.

	self assert: preferencesFile exists.
	self assert: preferencesFile size > 0.
	storedSettings := STON fromString: preferencesFile contents.
	self assert: storedSettings size equals: settings size.
	self
		assert: storedSettings first settingNodeIdentifier
		equals: settings first settingIdentifier.
	self
		assert: storedSettings second settingNodeIdentifier
		equals: settings second settingIdentifier
]

{ #category : 'tests - loading' }
SettingsManagerTest >> testStoredSettingForKnownSettingIdentifier [

	| file setting |
	file := FileSystem memory root / 'settings.ston'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: self stonStoredSettingsString ].
	manager fileReference: file.

	setting := manager storedSettingFor: '#pharoLauncher#templatesClearedOnStartup'.
	
	self assert: setting realValue equals: false
]

{ #category : 'tests - loading' }
SettingsManagerTest >> testStoredSettingForUnknownSettingIdentifierRaiseNotFound [

	| file |
	file := FileSystem memory root / 'settings.ston'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: self stonStoredSettingsString ].
	manager fileReference: file.

	self
		should: [ manager storedSettingFor: #unknown_setting ]
		raise: NotFound
]

{ #category : 'tests - storing - defaults' }
SettingsManagerTest >> testStoringNonDefaultValueAndThenStoringTheDefaultRemovesTheNode [

	"Store with a non default value"
	| booleanSetting |
	
	manager settings: SettingsTestData settings.
	booleanSetting := manager settingNamed: #shouldQuit.
	booleanSetting realValue: booleanSetting defaultValue not.
	manager storeSettings.
	self assert: preferencesFile exists.

	"Store with a default value"
	booleanSetting realValue: booleanSetting defaultValue.
	manager storeSettings.

	self assertStoredSettingsDoNotInclude: #shouldQuit
]

{ #category : 'tests' }
SettingsManagerTest >> testWriteStream [

	manager fileReference: preferencesFile.
	self deny: preferencesFile exists.
	self deny: preferencesFile parent exists.

	manager writeStreamDo: [ :stream | 
		self assert: stream isStream ]
]

{ #category : 'tests - storing' }
SettingsManagerTest >> testWritingStoredSettingsShouldNotCloseFileStream [

	| writeStream storedSettings |
	manager fileReference: preferencesFile.
	writeStream := preferencesFile ensureCreateFile writeStream.
	storedSettings := StoredSettingsFactory new fromSettingNodes:
		                  (Array with: SettingsTestData booleanSetting).
		
	manager storeExactStoredSettings: storedSettings on: writeStream.
	
	self deny: writeStream closed
]
