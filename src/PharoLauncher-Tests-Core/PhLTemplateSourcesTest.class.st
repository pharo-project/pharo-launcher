Class {
	#name : #PhLTemplateSourcesTest,
	#superclass : #TestCase,
	#instVars : [
		'sourcesFile'
	],
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #initialization }
PhLTemplateSourcesTest >> setUp [
	sourcesFile := FileSystem memory / 'templates-sources.test'
]

{ #category : #tests }
PhLTemplateSourcesTest >> testAlmostIdenticalTemplateSourcesAreDifferent [
	| templatesSources1 templatesSources2 |
	templatesSources1 := (PhLTemplateSources withTemplateList: PhLTemplateSources defaultSources) sources.
	templatesSources2 := (PhLTemplateSources withTemplateList: PhLTemplateSources defaultSources) sources.
	templatesSources2 second templates first name: 'changed'.
	
	self deny: templatesSources1 = templatesSources2
	
]

{ #category : #tests }
PhLTemplateSourcesTest >> testCanCreateInstanceFromAListOfTemplateSource [
	| tplSources sources |
	
	tplSources := PhLTemplateSources withTemplateList: { PhLTemplateSource officialDistributionsGroup }.
	sources := tplSources sources.
	
	self 
		assert: sources size
		equals: 1
	
]

{ #category : #tests }
PhLTemplateSourcesTest >> testCanFetchSourcesFileWhenAbsent [
	self deny: sourcesFile exists.
	
	(PhLTemplateSources withFile: sourcesFile) ensureSourcesFile. 
	
	self assert: sourcesFile exists
]

{ #category : #tests }
PhLTemplateSourcesTest >> testIdenticalTemplateSourcesAreEquals [
	| templatesSources1 templatesSources2 |
	templatesSources1 := (PhLTemplateSources withTemplateList: PhLTemplateSources defaultSources) sources.
	templatesSources2 := (PhLTemplateSources withTemplateList: PhLTemplateSources defaultSources) sources.
	
	self 
		assert: templatesSources1
		equals: templatesSources2
	
]

{ #category : #tests }
PhLTemplateSourcesTest >> testNoUpdateAnnouncedWhenDownloadedSourcesIsSameAsSources [
	| announcements sources |
	
	sourcesFile writeStreamDo: [ :stream | stream nextPutAll: (STON toString: true) ].
	
	announcements := OrderedCollection new. 
	ZnClientTests new 
	withServerDo: [ :server |
		server onRequestRespond: [ :request | 
			ZnResponse ok: (ZnEntity text: (STON toString: true)) ].
		
	sources := PhLTemplateSources withFile: sourcesFile.
	sources sourcesUrl: server localUrl.
	
	PhLTemplateSources announcer weak
		when: PhLSourcesFileUpdateAvailable
		send: #add:
		to: announcements.

	sources checkForUpdates.

	self assert: announcements isEmpty  ].
]

{ #category : #tests }
PhLTemplateSourcesTest >> testSourcesFileNotFetchIfPresentWhenCallingEnsureSourcesFile [
	sourcesFile ensureCreateFile.	
	
	(PhLTemplateSources withFile: sourcesFile) ensureSourcesFile. 
	
	self 
		assert: sourcesFile parent children size
		equals: 1
]

{ #category : #tests }
PhLTemplateSourcesTest >> testSourcesFileUpdateAvailableIsAnnouncedWhenDownloadedSourcesDifferentFromSources [
	| announcements sources |
	
	sourcesFile writeStreamDo: [ :stream | stream nextPutAll: (STON toString: true) ].
	
	announcements := OrderedCollection new. 
	ZnClientTests new 
	withServerDo: [ :server |
		server onRequestRespond: [ :request | 
			ZnResponse ok: (ZnEntity text: (STON toString: false)) ].
		
	sources := PhLTemplateSources withFile: sourcesFile.
	sources sourcesUrl: server localUrl.
	
	PhLTemplateSources announcer weak
		when: PhLSourcesFileUpdateAvailable
		send: #add:
		to: announcements.

	sources checkForUpdates.

	self 
		assert: announcements size 
		equals: 1 ].
]
