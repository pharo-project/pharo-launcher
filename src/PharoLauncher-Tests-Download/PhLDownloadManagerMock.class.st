"
I have the same interface as PhLDownloadManager but I don't do anything. Useful for testing without relying on network.
"
Class {
	#name : 'PhLDownloadManagerMock',
	#superclass : 'Object',
	#instVars : [
		'documents',
		'stamps',
		'stampRequestCount',
		'defaultResponse',
		'redirections',
		'redirectionRequestCount',
		'downloadCount'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'api' }
PhLDownloadManagerMock class >> during: aBlock [

	self install.
	[ aBlock value: PhLDownloadManager default ] ensure: [ self remove ]
]

{ #category : 'actions' }
PhLDownloadManagerMock class >> install [
	PhLDownloadManager setDefault: self new
]

{ #category : 'actions' }
PhLDownloadManagerMock class >> remove [
	PhLDownloadManager reset
]

{ #category : 'configuration' }
PhLDownloadManagerMock >> atUrl: anUrl answer: aDocument [
	self documents at: anUrl put: aDocument
]

{ #category : 'configuration' }
PhLDownloadManagerMock >> atUrl: anUrl answerStamp: aPhLRemoteFileStamp [
	self stamps at: anUrl put: aPhLRemoteFileStamp
]

{ #category : 'actions' }
PhLDownloadManagerMock >> download: aUrl toFile: aFileReference [ 
	
	| document |
	downloadCount := self downloadCount + 1.
	document := self documentAt: aUrl.
	aFileReference ensureDelete.
	aFileReference binaryWriteStreamDo: [ :aStream |
		aStream nextPutAll: (document isString
				 ifTrue: [ document utf8Encoded ]
				 ifFalse: [ document ]) ]
]

{ #category : 'actions' }
PhLDownloadManagerMock >> silentlyDownload: aUrl toFile: aFileReference [

	self download: aUrl toFile: aFileReference
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> defaultResponse [
	^ defaultResponse
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> defaultResponse: aString [ 
	defaultResponse := aString
]

{ #category : 'action' }
PhLDownloadManagerMock >> documentAt: anUrl [

	^ self documents
		  at: anUrl
		  ifPresent: [ :document | document ]
		  ifAbsent: [ self defaultResponse ]
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> documents [
	^ documents ifNil: [ documents := Dictionary new ]
]

{ #category : 'action' }
PhLDownloadManagerMock >> downloadToPositionableStream: anUrl [

	^ (self documentAt: anUrl) readStream
]

{ #category : 'action' }
PhLDownloadManagerMock >> downloadToPositionableStream: anUrl mimeType: aMimeType [ 
	"Ignore mime type"
	^ self downloadToPositionableStream: anUrl
]

{ #category : 'action' }
PhLDownloadManagerMock >> stampOf: anUrl [

	stampRequestCount := self stampRequestCount + 1.
	^ self stamps
		  at: anUrl
		  ifAbsent: [ PhLDownloadError signalUrl: anUrl ]
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> stamps [
	^ stamps ifNil: [ stamps := Dictionary new ]
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> stampRequestCount [
	"Number of times the stamp of a file was asked to the server"

	^ stampRequestCount ifNil: [ 0 ]
]

{ #category : 'configuration' }
PhLDownloadManagerMock >> stopAnsweringStampOf: anUrl [

	self stamps removeKey: anUrl ifAbsent: [ nil ]
]

{ #category : 'configuration' }
PhLDownloadManagerMock >> atUrl: anUrl redirectTo: aLocation [
	"aLocation nil means the server answers without redirecting"

	self redirections at: anUrl put: aLocation
]

{ #category : 'action' }
PhLDownloadManagerMock >> redirectionOf: anUrl [

	redirectionRequestCount := self redirectionRequestCount + 1.
	^ self redirections
		  at: anUrl
		  ifAbsent: [ PhLDownloadError signalUrl: anUrl ]
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> redirectionRequestCount [
	"Number of times the server was asked where it redirects a URL"

	^ redirectionRequestCount ifNil: [ 0 ]
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> redirections [

	^ redirections ifNil: [ redirections := Dictionary new ]
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> downloadCount [
	"Number of files downloaded"

	^ downloadCount ifNil: [ 0 ]
]
