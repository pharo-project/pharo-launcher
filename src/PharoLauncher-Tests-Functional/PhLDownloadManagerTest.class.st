Class {
	#name : 'PhLDownloadManagerTest',
	#superclass : 'TestCase',
	#instVars : [
		'downloadManager'
	],
	#category : 'PharoLauncher-Tests-Functional',
	#package : 'PharoLauncher-Tests-Functional'
}

{ #category : 'running' }
PhLDownloadManagerTest >> setUp [
	super setUp.
	
	downloadManager := PhLDownloadManager new.
]

{ #category : 'tests' }
PhLDownloadManagerTest >> testCanDownload [
	| downloadedFile |
	downloadedFile := FileSystem memory root / 'dwl'.
	
	downloadManager download: 'http://files.pharo.org/web-images/carousel/inspector.gif' toFile: downloadedFile.
	
	self assert: downloadedFile exists.
	self assert: downloadedFile size equals: 1330326.
	self assert: downloadManager numberOfErrors equals: 0.
	
]

{ #category : 'tests' }
PhLDownloadManagerTest >> testDownloadFailureIsSignaledToTheCaller [
	"The download manager opened a retry dialog it could not build"

	self
		should: [ downloadManager download: 'http://localhost:1/template.zip' asUrl toFile: FileSystem memory root / 'dwl' ]
		raise: PhLDownloadError
]
