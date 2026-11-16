"
I specify how downloaded templates are kept: a template is downloaded again only when the server publishes another archive.
The server is replaced by PhLDownloadManagerMock.
"
Class {
	#name : 'PhLDownloadedTemplateGroupTest',
	#superclass : 'TestCase',
	#instVars : [
		'group',
		'template'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLDownloadedTemplateGroupTest >> download [

	^ group downloadAndStoreFile: template url forTemplate: template
]

{ #category : 'helpers' }
PhLDownloadedTemplateGroupTest >> server [

	^ PhLDownloadManager default
]

{ #category : 'helpers' }
PhLDownloadedTemplateGroupTest >> serverPublishes: aString etag: anEtag [

	self server
		atUrl: template url answer: aString;
		atUrl: template url answerStamp: (PhLRemoteFileStamp etag: anEtag)
]

{ #category : 'running' }
PhLDownloadedTemplateGroupTest >> setUp [

	super setUp.
	PhLDownloadManagerMock install.
	group := PhLDownloadedTemplateGroup new
		         baseDirectory: FileSystem memory / 'templateCache';
		         yourself.
	template := PhLRemoteTemplate name: 'Pharo 14.0 - 64bit (stable)' url: 'https://files.pharo.org/image/140/latest-64.zip' asZnUrl
]

{ #category : 'running' }
PhLDownloadedTemplateGroupTest >> tearDown [

	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : 'tests' }
PhLDownloadedTemplateGroupTest >> testChangedArchiveIsDownloadedAgain [

	self serverPublishes: 'old' etag: 'a'.
	self download.
	self serverPublishes: 'new' etag: 'b'.

	self assert: self download contents equals: 'new'.
	self assert: self server downloadCount equals: 2
]

{ #category : 'tests' }
PhLDownloadedTemplateGroupTest >> testDeletedArchiveIsDownloadedAgain [

	self serverPublishes: 'archive' etag: 'a'.
	self download ensureDelete.

	self assert: self download contents equals: 'archive'.
	self assert: self server downloadCount equals: 2
]

{ #category : 'tests' }
PhLDownloadedTemplateGroupTest >> testFirstUseDownloadsTheArchive [

	self serverPublishes: 'archive' etag: 'a'.

	self assert: self download contents equals: 'archive'.
	self assert: self server downloadCount equals: 1
]

{ #category : 'tests' }
PhLDownloadedTemplateGroupTest >> testArchiveIsDownloadedAgainWhenServerDoesNotAnswer [

	self serverPublishes: 'archive' etag: 'a'.
	self download.
	self server stopAnsweringStampOf: template url.

	self download.

	self assert: self server downloadCount equals: 2
]

{ #category : 'tests' }
PhLDownloadedTemplateGroupTest >> testArchiveIsDownloadedAgainWhenServerCannotTellItChanged [

	self serverPublishes: 'archive' etag: nil.
	self download.

	self download.

	self assert: self server downloadCount equals: 2
]

{ #category : 'tests' }
PhLDownloadedTemplateGroupTest >> testArchiveOfAnotherUrlIsDownloaded [

	self serverPublishes: 'archive' etag: 'a'.
	self download.
	template := PhLRemoteTemplate name: template name url: 'https://files.pharo.org/image/140/other-64.zip' asZnUrl.
	self serverPublishes: 'other' etag: 'a'.

	self assert: self download contents equals: 'other'.
	self assert: self server downloadCount equals: 2
]

{ #category : 'tests' }
PhLDownloadedTemplateGroupTest >> testUnchangedArchiveIsNotDownloadedAgain [

	| archive |
	self serverPublishes: 'archive' etag: 'a'.
	archive := self download.

	self assert: self download equals: archive.
	self assert: archive contents equals: 'archive'.
	self assert: self server downloadCount equals: 1
]
