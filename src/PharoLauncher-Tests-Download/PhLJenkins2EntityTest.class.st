Class {
	#name : #PhLJenkins2EntityTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #testing }
PhLJenkins2EntityTest class >> isAbstract [
	^ self = PhLJenkins2EntityTest
]

{ #category : #'instance creation' }
PhLJenkins2EntityTest class >> newInstance [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
PhLJenkins2EntityTest class >> newSecureInstance [
	^ self subclassResponsibility
]

{ #category : #testing }
PhLJenkins2EntityTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #helpers }
PhLJenkins2EntityTest >> downloadManager [
	| manager |
	manager := PhLDownloadManager default.
	"If this assertion fails, you probably need to add a setUp method which calls PhLDownloadManagerMock>>install."
	self assert: (manager isKindOf: PhLDownloadManagerMock).
	^ manager
]

{ #category : #'instance creation' }
PhLJenkins2EntityTest >> newInstance [
	^ self class newInstance
]

{ #category : #'instance creation' }
PhLJenkins2EntityTest >> newSecureInstance [
	^ self class newSecureInstance
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
	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : #tests }
PhLJenkins2EntityTest >> testNonSecureJenkinsDoesNotIncludesIdentifiersInUrl [
	self deny: self newInstance url hasUsername.
	self deny: self newInstance url hasPassword
]

{ #category : #tests }
PhLJenkins2EntityTest >> testSecureJenkinsIncludesIdentifiersInUrl [
	self assert: self newSecureInstance url hasUsername.
	self assert: self newSecureInstance url hasPassword
]
