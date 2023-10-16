"
Create a file containing a ston with all the user settings used for the pharo launcher in command line. 
"
Class {
	#name : #PharoLauncherCLIConfiguration,
	#superclass : #Object,
	#instVars : [
		'imagesDirectory',
		'vmsDirectory',
		'launchImageFromALoginShell',
		'initScriptsDirectory'
	],
	#category : #'PharoLauncher-CLI-Model'
}

{ #category : #'error signalling' }
PharoLauncherCLIConfiguration class >> configFileNotFound: aFile [
	PhLNotificationCenter default outStream
		nextPutAll:
			'Config file not found, creating a new one at ';
		nextPutAll: self preferencesFile fullName;
		newLine.
	^ self createConfigurationFile: aFile
]

{ #category : #'instance creation' }
PharoLauncherCLIConfiguration class >> configurationFromFile: aFile [
	^ [ self fetchConfigurationFromFile: aFile ]
		on: FileDoesNotExistException
			do: [ self configFileNotFound: aFile ]

]

{ #category : #'instance creation' }
PharoLauncherCLIConfiguration class >> createConfigurationFile: aFileReference [ 
	| config |
	config := self new.
	aFileReference writeStreamDo: [ :stream |
		STON put: config onStreamPretty: stream ].
	^ config
]

{ #category : #accessing }
PharoLauncherCLIConfiguration class >> defaultConfiguration [
	^ self configurationFromFile: self preferencesFile 
]

{ #category : #'instance creation' }
PharoLauncherCLIConfiguration class >> fetchConfigurationFromFile: aFile [
	^ aFile
		readStreamDo: [ :stream | 
			[ STON fromStream: stream ]
				on: STONReaderError
				do: [ :error | 
					self logIncorrectConfigurationFile: aFile.
					PhLInvalidConfiguration signal: error messageText ] ]
]

{ #category : #'error signalling' }
PharoLauncherCLIConfiguration class >> logIncorrectConfigurationFile: aFile [
	PhLNotificationCenter default errorStream
		nextPutAll:
			'Incorrect config file, please changed it or delete it to create a default one ';
		newLine.
	^ self createConfigurationFile: aFile
]

{ #category : #accessing }
PharoLauncherCLIConfiguration class >> preferencesFile [
	^ (FileLocator launcherUserFilesLocation  / 'launcherSettings.ston') asFileReference 
]

{ #category : #accessing }
PharoLauncherCLIConfiguration class >> preferencesFileName [
	^ 'launcherSettings.ston'
]

{ #category : #comparing }
PharoLauncherCLIConfiguration >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ imagesDirectory = anObject imagesDirectory
		and: [ initScriptsDirectory = anObject initScriptsDirectory
				and: [ launchImageFromALoginShell = anObject launchImageFromALoginShell
						and: [ vmsDirectory = anObject vmsDirectory ] ] ]
]

{ #category : #comparing }
PharoLauncherCLIConfiguration >> hash [
	^ imagesDirectory hash
		bitXor:
			((initScriptsDirectory hash bitXor: launchImageFromALoginShell hash)
				bitXor: vmsDirectory hash)
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> imagesDirectory [
	^ imagesDirectory
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> imagesDirectory: aFileReference [ 
	imagesDirectory := aFileReference
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> initScriptsDirectory [
	^ initScriptsDirectory
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> initScriptsDirectory: aFileReference [ 
	initScriptsDirectory := aFileReference
]

{ #category : #initialization }
PharoLauncherCLIConfiguration >> initialize [
	super initialize.
	imagesDirectory := PhLDirectoryBasedImageRepository defaultLocation asFileReference .
	vmsDirectory := (FileLocator launcherUserFilesLocation / 'vms') asFileReference.
	initScriptsDirectory := PharoLauncherApplication 
		defaultInitializationScriptLocation asFileReference.
	launchImageFromALoginShell := PhLLaunchConfiguration launchInALoginShell
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> launchImageFromALoginShell [
	^ launchImageFromALoginShell
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> launchImageFromALoginShell: aBoolean [
	launchImageFromALoginShell := aBoolean
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> vmsDirectory [
	^ vmsDirectory
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> vmsDirectory: aFileReference [ 
	vmsDirectory := aFileReference
]
