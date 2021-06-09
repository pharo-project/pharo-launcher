"
Create a file containing a ston with all the user settings used for the pharo launcher in command line. 
"
Class {
	#name : #PharoLauncherCLIConfiguration,
	#superclass : #Object,
	#instVars : [
		'imageBaseRepository',
		'templateBaseRepository',
		'vmBaseRepository',
		'imageDirectory',
		'vmsDirectory',
		'launchImageFromALoginShell',
		'initScriptsDirectory',
		'pathFromConfigFile'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'as yet unclassified' }
PharoLauncherCLIConfiguration >> createDefaultConfigFile [
	| stream working pharoLauncherCLI collection   |
	collection := Dictionary new.
	imageDirectory := PhLDirectoryBasedImageRepository default.
	vmsDirectory := PhLVirtualMachineManager new.
	initScriptsDirectory := '//'.
	launchImageFromALoginShell := false.
	collection at: 'imageDirectory' put: imageDirectory .
	collection at: 'vmsDirectory' put: vmsDirectory .
	collection at: 'launchImageFromALoginShell' put: launchImageFromALoginShell.
	collection at: 'initScriptsDirectory' put: initScriptsDirectory .
	working := FileLocator preferences.
	pharoLauncherCLI := working/'pharoLauncherCLI'.
	pharoLauncherCLI createDirectory.
	stream := self preferencesFile writeStream.
	stream nextPutAll: (STON toString: collection) .
	stream close 
]

{ #category : #'as yet unclassified' }
PharoLauncherCLIConfiguration >> getConfiguration [
	| stream configDictionary |
	stream := self preferencesFile readStream.
	configDictionary := (STON fromString: stream contents).
	imageDirectory := configDictionary at: 'imageDirectory'.
	vmsDirectory := configDictionary at: 'vmsDirectory'.
	launchImageFromALoginShell := configDictionary at:'launchImageFromALoginShell'.
	initScriptsDirectory := configDictionary at: 'initScriptsDirectory'. 
	
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> imageDirectory [
	^ imageDirectory
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> initScriptsDirectory [
	^ initScriptsDirectory
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> initialize [ 
		super initialize.
		[self getConfiguration ] on:FileDoesNotExistException do: [ self createDefaultConfigFile].
		
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> launchImageFromALoginShell [
	^ launchImageFromALoginShell
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> preferencesFile [
	^ (self preferencesFolder / 'launcherSettings.ston') asFileReference 
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> preferencesFolder [
	^ FileLocator preferences / 'pharoLauncherCLI'
]

{ #category : #accessing }
PharoLauncherCLIConfiguration >> vmsDirectory [
	^ vmsDirectory
]
