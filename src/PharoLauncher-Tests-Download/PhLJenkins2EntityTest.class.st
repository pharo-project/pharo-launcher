Class {
	#name : #PhLJenkins2EntityTest,
	#superclass : #TestCase,
	#category : 'PharoLauncher-Tests-Download'
}

{ #category : #helpers }
PhLJenkins2EntityTest >> downloadManager [
	| manager |
	manager := PhLDownloadManager default.
	"If this assertion fails, you probably need to add a setUp method which calls PhLDownloadManagerMock>>install."
	self assert: (manager isKindOf: PhLDownloadManagerMock).
	^ manager
]

{ #category : #running }
PhLJenkins2EntityTest >> setUp [
	super setUp.
	PhLDownloadManagerMock install.
]

{ #category : #running }
PhLJenkins2EntityTest >> setUpResponse: aResponse [
	"Setup the mock Jenkins server to answer ==aResponse==."
	self downloadManager defaultResponse: aResponse
]

{ #category : #running }
PhLJenkins2EntityTest >> tearDown [
	super tearDown.
	PhLDownloadManagerMock remove.
]
