"
I represent the official template sources used by Pharo Launcher.

Preview :
	PhLTemplateGroupsBuilder buildFrom: PhLPharoTemplateSources fromFile.
	
Serialization:
	self generateSourcesFile
"
Class {
	#name : #PhLPharoTemplateSources,
	#superclass : #PhLTemplateSources,
	#classVars : [
		'DownloadedSourcesFileLock',
		'SourcesAnnouncer',
		'SourcesUrl'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLPharoTemplateSources class >> announcer [
	^ SourcesAnnouncer ifNil: [ SourcesAnnouncer := Announcer new ]
]

{ #category : #private }
PhLPharoTemplateSources class >> basicSourcesUrl: aUrl [

	| oldUrl |
	oldUrl := SourcesUrl.
	SourcesUrl := aUrl.
	
	^ oldUrl
]

{ #category : #updating }
PhLPharoTemplateSources class >> checkForUpdates [

	self fromFile checkForUpdates
]

{ #category : #accessing }
PhLPharoTemplateSources class >> defaultSources [
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
PhLPharoTemplateSources class >> defaultSourcesUrl [

	^ 'https://files.pharo.org/pharo-launcher/sources.list'
]

{ #category : #private }
PhLPharoTemplateSources class >> downloadedSourcesFileLock [
	^  DownloadedSourcesFileLock ifNil: [ DownloadedSourcesFileLock := Semaphore forMutualExclusion ].
]

{ #category : #accessing }
PhLPharoTemplateSources class >> fromFile [
	^ self withFile: self sourcesFile
]

{ #category : #reseting }
PhLPharoTemplateSources class >> resetSourcesUrl [
	self basicSourcesUrl: self defaultSourcesUrl
]

{ #category : #settings }
PhLPharoTemplateSources class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #sourcesUrl)
		label: 'Template sources Url' translated;
		parent: #pharoLauncher;
		target: self;
		order: 38;
		default: self defaultSourcesUrl;
		description: 'Url for downloading the template list'
]

{ #category : #accessing }
PhLPharoTemplateSources class >> sourcesFile [
	"File with the list of default templates sources for Pharo Launcher"
	^ self launcherCoreDir / self sourcesFileName
]

{ #category : #accessing }
PhLPharoTemplateSources class >> sourcesUrl [
	"Url of the file with the list of default templates sources for Pharo Launcher"

	^ SourcesUrl ifNil: [ SourcesUrl := self defaultSourcesUrl ]
]

{ #category : #accessing }
PhLPharoTemplateSources class >> sourcesUrl: aUrl [

	| oldUrl |
	oldUrl := self basicSourcesUrl: aUrl.
	oldUrl = SourcesUrl ifTrue: [ ^ self "ok" ].
	
	self checkForUpdates
]

{ #category : #actions }
PhLPharoTemplateSources >> checkForUpdates [
	| downloadedSources |
	
	file exists ifFalse: [ ^ self ensureSourcesFile ].
	self lockDownloadedSourcesFileDuring: [ 
		self downloadedSourcesFile ensureDelete.
		self fetchSourcesFile.
		downloadedSources := self downloadedSources. ].
	
	self sources = downloadedSources 
		ifFalse: [ self class announcer announce: (PhLSourcesFileUpdateAvailable sources: downloadedSources) ].
]

{ #category : #reading }
PhLPharoTemplateSources >> downloadedSources [
	| sources |
	self downloadedSourcesFile readStreamDo: [ :stream |
		 sources := STON fromStream: stream].
	^ sources
]

{ #category : #accessing }
PhLPharoTemplateSources >> downloadedSourcesFile [
	^ file parent / (file basename, '.dl')
]

{ #category : #accessing }
PhLPharoTemplateSources >> downloadedSourcesFileLock [
	"downloadedSourcesFileLock is a class variable because it points to a file that can only be used by one instance at a time."
	^ self class downloadedSourcesFileLock
]

{ #category : #accessing }
PhLPharoTemplateSources >> downloadedSourcesFileLockFile [
	^ file parent / (file basename, '.dl.lock')
]

{ #category : #actions }
PhLPharoTemplateSources >> ensureSourcesFile [
	file exists ifTrue: [ ^ file ].
	
	self fetchSourcesFile.
	self downloadedSourcesFile exists 
		ifFalse: [ PhLUIInformation new 
						message: 'Cannot fetch Pharo Launcher template sources file: {1}'. ].
	self replaceSourcesFileWithDownloaded.
]

{ #category : #actions }
PhLPharoTemplateSources >> fetchSourcesFile [
	"Avoid to have a retry dialog"
	PhLDownloadManager default
		basicDownload: self sourcesUrl
		toFile: self downloadedSourcesFile. 
	
]

{ #category : #accessing }
PhLPharoTemplateSources >> file [
	^ file
]

{ #category : #private }
PhLPharoTemplateSources >> lockDownloadedSourcesFileDuring: aBlock [
	self downloadedSourcesFileLockFile exists
		ifTrue: [ | lockDate |
			lockDate := DateAndTime fromString: self downloadedSourcesFileLockFile contents.
			(DateAndTime now - lockDate > 1 day)
				ifTrue: [ self downloadedSourcesFileLockFile ensureDelete "there was probably a problem during the update" ]
				ifFalse: [ ^ self "File already locked, do not execute the block" ] ]. 
	
	"Ensure file is locked if another Launcher instance (another image) is open".
	self downloadedSourcesFileLockFile 
		writeStreamDo: [ :stream | stream nextPutAll: DateAndTime now asString ]. 
	"Lock working for this image."
	[ self downloadedSourcesFileLock critical: aBlock ]
	ensure: [ self downloadedSourcesFileLockFile ensureDelete ]
]

{ #category : #actions }
PhLPharoTemplateSources >> replaceSourcesFileWithDownloaded [
	file ensureDelete.
	self downloadedSourcesFile moveTo: file 
]

{ #category : #accessing }
PhLPharoTemplateSources >> sources [
	self ensureSourcesFile.
	^ super sources
]

{ #category : #accessing }
PhLPharoTemplateSources >> sourcesUrl [

	^ self class sourcesUrl
]

{ #category : #actions }
PhLPharoTemplateSources >> updateSourcesFile [
	self downloadedSourcesFile exists ifFalse: [ ^ self "nothing to update" ].
	
	self replaceSourcesFileWithDownloaded
]
