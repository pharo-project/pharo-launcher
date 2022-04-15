"
I represent download errors.
I can be added as a node to the template tree. That's why I have some methods to say I have no children and I am not a template (polymorphism with PhLAbstractTemplate)
"
Class {
	#name : #PhLDownloadError,
	#superclass : #PhLError,
	#instVars : [
		'url'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #signalling }
PhLDownloadError class >> signalUrl: anUrl [
	^ self new
		setUrl: anUrl;
		signal
]

{ #category : #signalling }
PhLDownloadError class >> signalUrl: anUrl message: errorMessage [
	^ self new
		setUrl: anUrl;
		messageText: errorMessage;
		signal
]

{ #category : #polymorphism }
PhLDownloadError >> hasChildren [ 
	^ false
]

{ #category : #polymorphism }
PhLDownloadError >> isTemplate [
	^ false
]

{ #category : #accessing }
PhLDownloadError >> longDescription [
	^ String streamContents: [ :stream |
		stream 
			nextPutAll: 'Error downloading ';
			nextPutAll: (url printStringLimitedTo: 100).
		messageText ifNotNil: [ stream cr; nextPutAll: messageText ] ]
]

{ #category : #accessing }
PhLDownloadError >> name [
	^ 'network error'
]

{ #category : #initialization }
PhLDownloadError >> setUrl: anUrl [	
	url := anUrl
]
