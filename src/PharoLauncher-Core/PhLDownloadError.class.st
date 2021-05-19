"
I represent download errors.
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

{ #category : #accessing }
PhLDownloadError >> longDescription [
	^ 'Error downloading ', (url printStringLimitedTo: 100)
]

{ #category : #accessing }
PhLDownloadError >> name [
	^ 'network error'
]

{ #category : #initialization }
PhLDownloadError >> setUrl: anUrl [	
	url := anUrl
]
