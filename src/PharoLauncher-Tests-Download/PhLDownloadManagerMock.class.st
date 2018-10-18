"
I have the same interface as PhLDownloadManager but I don't do anything. Useful for testing without relying on network.
"
Class {
	#name : #PhLDownloadManagerMock,
	#superclass : #Object,
	#instVars : [
		'documents',
		'defaultResponse'
	],
	#category : 'PharoLauncher-Tests-Download'
}

{ #category : #actions }
PhLDownloadManagerMock class >> install [
	PhLDownloadManager setDefault: self new
]

{ #category : #actions }
PhLDownloadManagerMock class >> remove [
	PhLDownloadManager reset
]

{ #category : #configuration }
PhLDownloadManagerMock >> atUrl: anUrl answer: aDocument [
	self documents at: anUrl put: aDocument
]

{ #category : #accessing }
PhLDownloadManagerMock >> defaultResponse [
	^ defaultResponse
]

{ #category : #accessing }
PhLDownloadManagerMock >> defaultResponse: aString [ 
	defaultResponse := aString
]

{ #category : #accessing }
PhLDownloadManagerMock >> documents [
	^ documents ifNil: [ documents := Dictionary new ]
]

{ #category : #action }
PhLDownloadManagerMock >> downloadToPositionableStream: anUrl [
	^ self documents at: anUrl ifPresent: [:document | document readStream] ifAbsent: [ self defaultResponse readStream ]
]

{ #category : #action }
PhLDownloadManagerMock >> downloadToPositionableStream: anUrl mimeType: aMimeType [ 
	"Ignore mime type"
	^ self downloadToPositionableStream: anUrl
]
