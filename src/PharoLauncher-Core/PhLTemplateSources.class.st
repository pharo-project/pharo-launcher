"
I represent default template sources fo Pharo Launcher.

Preview in Launcher:
	| groups |
	groups := PhLTemplateListBuilder buildFrom: PhLTemplateSources default.
	(PharoLauncher createLauncherWithGroups: groups) openWithSpec.

Serialization preview:
	self flushIn: '/tmp/a' asFileReference
Serialization:
	self generateSourcesFile
"
Class {
	#name : #PhLTemplateSources,
	#superclass : #Object,
	#instVars : [
		'file',
		'announcer',
		'sourcesUrl'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #serializing }
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

{ #category : #serializing }
PhLTemplateSources class >> flushIn: aFileReference [
	aFileReference writeStreamDo: [ :stream |
		STON 
			put: self defaultSources
			onStreamPretty: stream ].
	^ aFileReference 
]

{ #category : #accessing }
PhLTemplateSources class >> fromFile [
	^ self with: self sourcesFile
]

{ #category : #serializing }
PhLTemplateSources class >> generateSourcesFile [
	self flushIn: self sourcesFile
]

{ #category : #accessing }
PhLTemplateSources class >> sourcesFile [
	"File with the list of default templates sources for Pharo Launcher"
	^ PlatformResolver forCurrentPlatform launcherUserFilesLocation / 'sources.list'
]

{ #category : #'instance creation' }
PhLTemplateSources class >> with: aSourcesFile [
	^ self new 
		initializeWith: aSourcesFile;
		yourself
]

{ #category : #accessing }
PhLTemplateSources >> announcer [
	^ announcer
]

{ #category : #actions }
PhLTemplateSources >> checkForUpdates [
	| downloadedSources |
	file exists ifFalse: [ ^ self ensureSourcesFile ].
	self downloadedSourcesFile exists ifFalse: [ self fetchSourcesFile ].
	
	downloadedSources := self downloadedSources.
	self sources = downloadedSources
		ifFalse: [ announcer announce: (PhLSourcesFileUpdateAvailable sources: downloadedSources) ].
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
	announcer := Announcer new
]

{ #category : #actions }
PhLTemplateSources >> replaceSourcesFileWithDownloaded [
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
	"Url of the file with the list of default templates sources for Pharo Launcher"
	^ sourcesUrl ifNil: [ sourcesUrl := 'https://files.pharo.org/pharo-launcher/sources.list']
]

{ #category : #accessing }
PhLTemplateSources >> sourcesUrl: anUrlString [
	sourcesUrl := anUrlString
]

{ #category : #actions }
PhLTemplateSources >> updateSourcesFile [
	self replaceSourcesFileWithDownloaded
]
