Class {
	#name : #PharoLauncherCLIConfigurationTest,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #utility }
PharoLauncherCLIConfigurationTest >> createPreferencesFileWith: aConfiguration [
	| preferencesFile |
	preferencesFile := root / PharoLauncherCLIConfiguration preferencesFileName.
	preferencesFile writeStreamDo: [ :stream |
		STON put: aConfiguration onStreamPretty: stream ].
	^ preferencesFile 

]

{ #category : #running }
PharoLauncherCLIConfigurationTest >> setUp [
	super setUp.
	root := FileSystem memory root.

]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testConfigurationsWithDifferentValuesShoudNotBeEqual [
	| config1 config2 |
	config1 := PharoLauncherCLIConfiguration new
		imagesDirectory: FileLocator imageDirectory;
		vmsDirectory: FileLocator vmDirectory;
		initScriptsDirectory: FileLocator launcherUserFilesLocation / 'scripts';
		launchImageFromALoginShell: true.
	config2 := PharoLauncherCLIConfiguration new
		imagesDirectory: 'foo';
		vmsDirectory: FileLocator vmDirectory;
		initScriptsDirectory: FileLocator launcherUserFilesLocation / 'scripts';
		launchImageFromALoginShell: true.

	self deny: config1 equals: config2
]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testConfigurationsWithSameValuesShoudBeEqual [
	| config1 config2 |
	config1 := PharoLauncherCLIConfiguration new
		imagesDirectory: FileLocator imageDirectory;
		vmsDirectory: FileLocator vmDirectory;
		initScriptsDirectory: FileLocator launcherUserFilesLocation / 'scripts';
		launchImageFromALoginShell: true.
	config2 := PharoLauncherCLIConfiguration new
		imagesDirectory: FileLocator imageDirectory;
		vmsDirectory: FileLocator vmDirectory;
		initScriptsDirectory: FileLocator launcherUserFilesLocation / 'scripts';
		launchImageFromALoginShell: true.

	self assert: config1 equals: config2
]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testGetConfigurationWhenConfigurationFileAbsentShouldCreateDefaultConfiguration [
	
	| config |
	config := PharoLauncherCLIConfiguration configurationFromFile: (root / 'launcherSettings.ston') asFileReference .
	
	self assert: (config isKindOf: PharoLauncherCLIConfiguration)
]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testGetConfigurationWhenConfigurationFileExistsShouldSucceed [
	| config preferencesFile |
	preferencesFile := self createPreferencesFileWith: PharoLauncherCLIConfiguration new.
	
	config := PharoLauncherCLIConfiguration configurationFromFile: preferencesFile.
	
	self assert: (config isKindOf: PharoLauncherCLIConfiguration)
]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testGetConfigurationWhenInvalidConfigurationFileShouldXXXXX [
	| root preferencesFile |
	root := FileSystem memory root.
	preferencesFile := root / PharoLauncherCLIConfiguration preferencesFileName.
	preferencesFile ensureCreateFile.
	
	PharoLauncherCLIConfiguration configurationFromFile: preferencesFile
]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testReadOfSerializedConfigurationShouldGiveBackSameConfiguration [
	| config preferencesFile serializedConfig |
	config := PharoLauncherCLIConfiguration new.
	config 
		imagesDirectory: FileLocator imageDirectory;
		vmsDirectory: FileLocator vmDirectory;
		initScriptsDirectory: FileLocator launcherUserFilesLocation / 'scripts';
		launchImageFromALoginShell: true.
	
	preferencesFile := self createPreferencesFileWith: config.
	serializedConfig := PharoLauncherCLIConfiguration configurationFromFile: preferencesFile.
	
	self assert: serializedConfig equals: config
]
