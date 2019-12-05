"
I represent the template sources used by Pharo Launcher.

Preview in Launcher:
	| groups |
	groups := PhLTemplateGroupsBuilder buildFrom: PhLTemplateSources fromFile.
	(PharoLauncher createLauncherWithGroups: groups) openWithSpec.

Serialization:
	self generateSourcesFile
"
Class {
	#name : #PhLTemplateSources,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#classVars : [
		'DownloadedSourcesFileLock',
		'LauncherCoreDir',
		'SourcesAnnouncer',
		'SourcesUrl'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLTemplateSources class >> announcer [
	^ SourcesAnnouncer ifNil: [ SourcesAnnouncer := Announcer new ]
]

{ #category : #updating }
PhLTemplateSources class >> checkForUpdates [

	self fromFile checkForUpdates
]

{ #category : #accessing }
PhLTemplateSources class >> defaultSources [
	^ OrderedCollection new 
		add: PhLTemplateSource cacheGroup;
		add: PhLTemplateSource moocGroup;
		add: PhLTemplateSource officialDistributionsGroup;
		add: PhLTemplateSource deprecatedDistributionsGroup;
		add: PhLTemplateSource inriaPharoContribution;
		add: PhLTemplateSource inriaMoose;
		add: PhLTemplateSource pharo60;
		add: PhLTemplateSource pharo70;
		yourself
]

{ #category : #accessing }
PhLTemplateSources class >> defaultSourcesUrl [

	^ 'https://files.pharo.org/pharo-launcher/sources.list'
]

{ #category : #private }
PhLTemplateSources class >> downloadedSourcesFileLock [
	^  DownloadedSourcesFileLock ifNil: [ DownloadedSourcesFileLock := Semaphore forMutualExclusion ].
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

{ #category : #accessing }
PhLTemplateSources class >> fromFile [
	^ self withFile: self sourcesFile
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

{ #category : #reseting }
PhLTemplateSources class >> resetSourcesUrl [
	self sourcesUrl: self defaultSourcesUrl
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
	(aBuilder setting: #sourcesUrl)
		label: 'Template sources Url' translated;
		parent: #pharoLauncher;
		target: self;
		order: 38;
		default: self defaultSourcesUrl;
		description: 'Url for downloading the template list'
]

{ #category : #accessing }
PhLTemplateSources class >> sourcesFile [
	"File with the list of default templates sources for Pharo Launcher"
	^ self launcherCoreDir / 'sources.list'
]

{ #category : #accessing }
PhLTemplateSources class >> sourcesUrl [
	"Url of the file with the list of default templates sources for Pharo Launcher"

	^ SourcesUrl ifNil: [ SourcesUrl := self defaultSourcesUrl ]
]

{ #category : #accessing }
PhLTemplateSources class >> sourcesUrl: aUrl [

	| oldUrl |
	oldUrl := SourcesUrl.
	SourcesUrl := aUrl.
	
	oldUrl = SourcesUrl ifTrue: [ ^ self "ok" ].
	PhLTemplateSources checkForUpdates
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

{ #category : #actions }
PhLTemplateSources >> checkForUpdates [
	| downloadedSources |
	file exists ifFalse: [ ^ self ensureSourcesFile ].
	self downloadedSourcesFileLock
		critical: 
		[ self downloadedSourcesFile ensureDelete.
		self fetchSourcesFile.
		downloadedSources := self downloadedSources. ].
	
	self sources = downloadedSources
		ifFalse: [ self class announcer announce: (PhLSourcesFileUpdateAvailable sources: downloadedSources) ].
]

{ #category : #iterating }
PhLTemplateSources >> collect: aBlock [
	^ self sources collect: aBlock
]

{ #category : #reading }
PhLTemplateSources >> downloadedSources [
	| sources |
	self downloadedSourcesFile readStreamDo: [ :stream |
		 sources := STON fromStream: stream].
	^ sources
]

{ #category : #accessing }
PhLTemplateSources >> downloadedSourcesFile [
	^ file parent / (file basename, '.dl')
]

{ #category : #accessing }
PhLTemplateSources >> downloadedSourcesFileLock [
	"downloadedSourcesFileLock is a class variable because it points to a file that can only be used by one instance at a time."
	^ self class downloadedSourcesFileLock
]

{ #category : #actions }
PhLTemplateSources >> ensureSourcesFile [
	file exists ifTrue: [ ^ file ].
	
	self fetchSourcesFile.
	self downloadedSourcesFile exists 
		ifFalse: [ PhLUIInformation new 
						message: 'Cannot fetch Pharo Launcher template sources file: {1}'. ].
	self replaceSourcesFileWithDownloaded.
]

{ #category : #actions }
PhLTemplateSources >> fetchSourcesFile [
	PhLDownloadManager default
		download: self sourcesUrl
		toFile: self downloadedSourcesFile. 
	
]

{ #category : #initialization }
PhLTemplateSources >> initializeWith: aSourcesFile [
	file := aSourcesFile.
]

{ #category : #actions }
PhLTemplateSources >> replaceSourcesFileWithDownloaded [
	file ensureDelete.
	self downloadedSourcesFile moveTo: file 
]

{ #category : #reading }
PhLTemplateSources >> sources [
	| sources |
	file readStreamDo: [ :stream |
		 sources := STON fromStream: stream].
	^ sources
]

{ #category : #accessing }
PhLTemplateSources >> sourcesUrl [

	^ self class sourcesUrl
]

{ #category : #actions }
PhLTemplateSources >> updateSourcesFile [
	self replaceSourcesFileWithDownloaded
]
