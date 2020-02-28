Class {
	#name : #PhLJenkins2BuildTest,
	#superclass : #PhLJenkins2EntityTest,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #'instance creation' }
PhLJenkins2BuildTest class >> newInstance [
	^ self newWithoutParent
		  parent: PhLJenkins2JobTest newInstance;
		  yourself
]

{ #category : #'instance creation' }
PhLJenkins2BuildTest class >> newSecureInstance [
	^ self newWithoutParent
		  parent: PhLJenkins2JobTest newSecureInstance;
		  yourself
]

{ #category : #'instance creation' }
PhLJenkins2BuildTest class >> newWithoutParent [
	^ PhLJenkins2Build newWithProperties: (STONJSON fromString:
			   '{"_class":"hudson.matrix.MatrixBuild","url":"https://ci.inria.fr/moose/job/ClassNamesAnalyzer/223/","number":223}')
]

{ #category : #helpers }
PhLJenkins2BuildTest >> artifactRelativePath [
	^ 'foo.zip'
]

{ #category : #helpers }
PhLJenkins2BuildTest >> buildNumber [
	^ 52
]

{ #category : #helpers }
PhLJenkins2BuildTest >> buildUrlString [
	^ 'http://server/build'
]

{ #category : #'instance creation' }
PhLJenkins2BuildTest >> emptyBuild [
	^ (PhLJenkins2Build newWithProperties: (Dictionary new
				    at: 'number' put: self buildNumber;
				    at: 'url' put: self buildUrlString;
				    yourself))
		  parent: PhLJenkins2JobTest newSecureInstance;
		  yourself
]

{ #category : #'instance creation' }
PhLJenkins2BuildTest >> emptyLastSuccessfulBuild [
	^ (PhLJenkins2Build newWithProperties: (Dictionary new
				    at: 'number' put: self buildNumber;
				    at: 'url' put: self lastSuccessfulBuildUrlString;
				    yourself))
		  parent: PhLJenkins2JobTest newSecureInstance;
		  yourself
]

{ #category : #helpers }
PhLJenkins2BuildTest >> lastSuccessfulBuildUrlString [
	^ 'http://server/lastSuccessfulBuild'
]

{ #category : #responses }
PhLJenkins2BuildTest >> oneArtifactResponse [
	^ '{"artifacts" : [
		{ "relativePath" : "', self artifactRelativePath,'" }
		]}'
]

{ #category : #responses }
PhLJenkins2BuildTest >> oneRunResponse [
	^ '{"runs" : [
		{ "number" : ',self runNumber printString,',
		   "url" : "', self runUrlString,'" }
		]}' 
]

{ #category : #helpers }
PhLJenkins2BuildTest >> runNumber [
	^ 52
]

{ #category : #helpers }
PhLJenkins2BuildTest >> runUrlString [
	^ 'http://server/run'
]

{ #category : #tests }
PhLJenkins2BuildTest >> testBuildWithArtifacts [
	| artifact |
	self setUpResponse: self oneArtifactResponse.
	self assert: self emptyBuild runs isEmpty.
	self assert: self emptyBuild artifacts size equals: 1.
	artifact := self emptyBuild artifacts first.
	self assert: artifact relativePath equals: self artifactRelativePath.
	self assert: artifact url equals: self buildUrlString asUrl / 'artifact' / self artifactRelativePath
]

{ #category : #tests }
PhLJenkins2BuildTest >> testBuildWithRuns [
	| run |
	self setUpResponse: self oneRunResponse.
	self assert: self emptyBuild artifacts isEmpty.
	self assert: self emptyBuild runs size equals: 1.
	run := self emptyBuild runs first.
	self assert: run number equals: self runNumber
]

{ #category : #tests }
PhLJenkins2BuildTest >> testEmptyBuild [
	self setUpResponse: '{}'.
	self assert: self emptyBuild artifacts isEmpty.
	self assert:self emptyBuild runs isEmpty.
]

{ #category : #tests }
PhLJenkins2BuildTest >> testLastSuccessfulBuildPropagateTag [
	| run build |
	self setUpResponse: self oneRunResponse.
	build := self emptyLastSuccessfulBuild.
	self assert: build runs size equals: 1.
	run := build runs first.
	self assert: run url copy removeLastPathSegment lastPathSegment equals: 'lastSuccessfulBuild'
]
