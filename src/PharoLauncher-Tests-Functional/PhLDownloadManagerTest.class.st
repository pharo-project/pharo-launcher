Class {
	#name : #PhLDownloadManagerTest,
	#superclass : #TestCase,
	#instVars : [
		'downloadManager'
	],
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #running }
PhLDownloadManagerTest >> setUp [
	super setUp.
	
	downloadManager := PhLDownloadManager new.
]

{ #category : #tests }
PhLDownloadManagerTest >> testCanDownload [
	| downloadedFile |
	downloadedFile := FileSystem memory root / 'dwl'.
	
	downloadManager download: 'http://files.pharo.org/web-images/carousel/inspector.gif' toFile: downloadedFile.
	
	self assert: downloadedFile exists.
	self assert: downloadedFile size equals: 1330326.
	self assert: downloadManager numberOfErrors equals: 0.
	
]
