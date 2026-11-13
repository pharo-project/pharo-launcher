"
I have the same interface as PhLDownloadManager but I don't do anything. Useful for testing without relying on network.
"
Class {
	#name : 'PhLDownloadManagerMock',
	#superclass : 'Object',
	#instVars : [
		'documents',
		'stamps',
		'defaultResponse'
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
	document := self documentAt: aUrl.
	aFileReference ensureDelete.
	aFileReference binaryWriteStreamDo: [ :aStream |
		aStream nextPutAll: (document isString
				 ifTrue: [ document utf8Encoded ]
				 ifFalse: [ document ]) ]
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

	^ self stamps
		  at: anUrl
		  ifAbsent: [ PhLDownloadError signalUrl: anUrl ]
]

{ #category : 'accessing' }
PhLDownloadManagerMock >> stamps [
	^ stamps ifNil: [ stamps := Dictionary new ]
]
