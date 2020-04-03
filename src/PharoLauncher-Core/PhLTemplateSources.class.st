"
I represent a list of template sources used by Pharo Launcher.

You initialize me with a reference to a file (serialized with Ston) and then, you can ask me the list of PhlTemplateSource (you can see them as template groups).

ex:
 	(self withFile: PhLPharoTemplateSources sourcesFile) sources 
"
Class {
	#name : #PhLTemplateSources,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#classVars : [
		'LauncherCoreDir'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLTemplateSources class >> defaultSources [ 
	^ PhLCompositeTemplateSources new 
			initializeWith: { PhLPharoTemplateSources fromFile . PhLUserTemplateSources fromFile };
			yourself
]

{ #category : #example }
PhLTemplateSources class >> example [
	^ self withFile: PhLPharoTemplateSources sourcesFile
]

{ #category : #serializing }
PhLTemplateSources class >> flush: aListOfPhLTemplateSource in: aFileReference [
	aFileReference writeStreamDo: [ :stream |
		STON 
			put: aListOfPhLTemplateSource
			onStreamPretty: stream ].
	^ aFileReference 
]

{ #category : #serializing }
PhLTemplateSources class >> flushIn: aFileReference [
	self flush: self defaultSources in: aFileReference
	
]

{ #category : #'instance creation' }
PhLTemplateSources class >> fromFile [
	self subclassResponsibility
]

{ #category : #serializing }
PhLTemplateSources class >> generateSourcesFile [
	self flushIn: self sourcesFile
]

{ #category : #accessing }
PhLTemplateSources class >> launcherCoreDir [
	^ (LauncherCoreDir ifNil: [ LauncherCoreDir := PlatformResolver forCurrentPlatform launcherUserFilesLocation ]) ensureCreateDirectory
]

{ #category : #accessing }
PhLTemplateSources class >> launcherCoreDir: aFileUrl [
	LauncherCoreDir := aFileUrl asFileReference.
	LauncherCoreDir ensureCreateDirectory
]

{ #category : #accessing }
PhLTemplateSources class >> launcherCoreDirString [
	" Used to display a nice file url in settings browser"
	^ self launcherCoreDir pathString 
]

{ #category : #accessing }
PhLTemplateSources class >> launcherCoreDirString: aFileUrl [
	" Used to display a nice file url in settings browser"
	self launcherCoreDir: aFileUrl

]

{ #category : #updating }
PhLTemplateSources class >> resetLauncherCoreDir [
	LauncherCoreDir := nil
]

{ #category : #settings }
PhLTemplateSources class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #launcherCoreDirString)
		label: 'Location of template sources file' translated;
		type: #Directory;
		parent: #pharoLauncher;
		target: self;
		order: 37;
		default: PlatformResolver forCurrentPlatform launcherUserFilesLocation;
		description:
			'Path to the directory that will contain Pharo Launcher template sources file.' , String cr
				, 'You must have the read/write rights on this folder.' , String cr
				, 'NOTE: This path might need to escape some whitespace characters.' translated.
]

{ #category : #'instance creation' }
PhLTemplateSources class >> withFile: aSourcesFile [
	^ self new 
		initializeWith: aSourcesFile;
		yourself
]

{ #category : #'instance creation' }
PhLTemplateSources class >> withTemplateList: aListOfPhLTemplateSource [
	| file |
	file := FileSystem memory / 'sources.list'.
	self flush: aListOfPhLTemplateSource in: file.
	^ self withFile: file
]

{ #category : #iterating }
PhLTemplateSources >> collect: aBlock [
	^ self sources collect: aBlock
]

{ #category : #initialization }
PhLTemplateSources >> initializeWith: aSourcesFile [
	file := aSourcesFile.
]

{ #category : #accessing }
PhLTemplateSources >> sources [
	| sources |
	file exists 
		ifFalse: [ ^ #() ].
	
	[ file readStreamDo: [ :stream |
		 sources := STON fromStream: stream] ]
	on: STONReaderError, InstanceVariableNotFound  
	do: [ sources := #() ].
	^ sources
]
