Class {
	#name : #PharoLauncherCLIConfigurationTest,
	#superclass : #TestCase,
	#instVars : [
		'root',
		'errorStream',
		'outStream'
	],
	#category : #'PharoLauncher-CLI-Tests'
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
	outStream := WriteStream on: (String new).
	errorStream := WriteStream on: (String new).
	PhLNotificationCenter default 
		errorStream: errorStream;
		outStream: outStream.

]

{ #category : #running }
PharoLauncherCLIConfigurationTest >> tearDown [
	PhLNotificationCenter default errorStream close.

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
	
	self assert: (config isKindOf: PharoLauncherCLIConfiguration).
	self assert: (PhLNotificationCenter default outStream contents includesSubstring: 'Config') 
	
	
]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testGetConfigurationWhenConfigurationFileExistsShouldSucceed [
	| config preferencesFile |
	preferencesFile := self createPreferencesFileWith: PharoLauncherCLIConfiguration new.
	
	config := PharoLauncherCLIConfiguration configurationFromFile: preferencesFile.
	
	self assert: (config isKindOf: PharoLauncherCLIConfiguration)
]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testGetConfigurationWhenInvalidConfigurationFileShouldGiveExplainationMessage [
	"unable to read the file , correct or delete"
	|  preferencesFile |
	root := FileSystem memory root.
	preferencesFile := root / PharoLauncherCLIConfiguration preferencesFileName.
	preferencesFile ensureCreateFile.
	
	self should: ([PharoLauncherCLIConfiguration configurationFromFile: preferencesFile.] ) raise: PhLInvalidConfiguration.
	self assert: ( PhLNotificationCenter default errorStream contents includesSubstring: 'Incorrect config file, please changed ' ) 
	

]

{ #category : #tests }
PharoLauncherCLIConfigurationTest >> testGetStableTemplateWhenGivingWrongDefaultTemplateValue [

	| config deserializeConfig |
	config := PharoLauncherCLIConfiguration new.
	self assert: config defaultTemplate equals: #stable.
	
	config defaultTemplate: #foo.
	deserializeConfig := STON fromString: (STON toString: config).
	self assert: deserializeConfig defaultTemplate equals: #stable.

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
	serializedConfig := PharoLauncherCLIConfiguration
		configurationFromFile: preferencesFile.
	self assert: serializedConfig equals: config
]
