Class {
	#name : #PhLJenkins2JobTest,
	#superclass : #PhLJenkins2EntityTest,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #helpers }
PhLJenkins2JobTest class >> newInstance [
	| job |
	job := PhLJenkins2Job
		newWithProperties: (STONJSON fromString: '{"_class":"hudson.matrix.MatrixBuild","url":"https://ci.inria.fr/pharo-contribution/job/A4BP/1304/","number":1304}').
	job parent: PhLJenkins2ServerTest newInstance.
	^ job
]

{ #category : #helpers }
PhLJenkins2JobTest class >> newSecureJenkinsInstance [
	| job |
	job := PhLJenkins2Job
		newWithProperties: (STONJSON fromString: '{"_class":"hudson.matrix.MatrixBuild","url":"https://ci.inria.fr/pharo-contribution/job/A4BP/1304/","number":1304}').
	job parent: PhLJenkins2ServerTest newSecureJenkinsInstance.
	^ job
]

{ #category : #helpers }
PhLJenkins2JobTest >> lastSuccessfulBuildNumber [
	^ 52
]

{ #category : #helpers }
PhLJenkins2JobTest >> lastSuccessfulBuildUrlString [
	^ 'http://server/build'
]

{ #category : #'instance creation' }
PhLJenkins2JobTest >> newJobWithNoSuccessfulBuild [
	^ (PhLJenkins2Job newWithProperties: (Dictionary new
				    at: 'url' put: 'url' asUrl;
				    at: 'name' put: 'thejob';
				    yourself))
		  parent: PhLJenkins2ServerTest newInstance;
		  yourself
]

{ #category : #'instance creation' }
PhLJenkins2JobTest >> newJobWithNullSuccessfulBuild [
	^ (PhLJenkins2Job newWithProperties: (Dictionary new
				    at: 'url' put: 'url' asUrl;
				    at: 'name' put: 'thejob';
				    at: 'lastSuccessfulBuild' put: nil;
				    yourself))
		  parent: PhLJenkins2ServerTest newInstance;
		  yourself
]

{ #category : #'instance creation' }
PhLJenkins2JobTest >> newJobWithSuccessfulBuild [
	^ (PhLJenkins2Job newWithProperties: (Dictionary new
				    at: 'url' put: 'url' asUrl;
				    at: 'name' put: 'thejob';
				    at: 'lastSuccessfulBuild' put: (Dictionary newFromPairs: { 
								     'number'.
								     self lastSuccessfulBuildNumber.
								     'url'.
								     self lastSuccessfulBuildUrlString });
				    yourself))
		  parent: PhLJenkins2ServerTest newInstance;
		  yourself
]

{ #category : #responses }
PhLJenkins2JobTest >> noBuildsResponse [
	^ '{"builds" : []}'
]

{ #category : #responses }
PhLJenkins2JobTest >> oneBuildResponse [
	^ '{"builds" : [
    {
      "number" : ',self lastSuccessfulBuildNumber printString,',
      "url" : "',self lastSuccessfulBuildUrlString,'"
    }]}'
]

{ #category : #tests }
PhLJenkins2JobTest >> testJobWithNoSuccessfulBuild [
	self setUpResponse: self noBuildsResponse.
	self assert: self newJobWithNoSuccessfulBuild builds isEmpty
]

{ #category : #tests }
PhLJenkins2JobTest >> testJobWithNullSuccessfulBuild [
	self setUpResponse: self noBuildsResponse.
	self assert: self newJobWithNullSuccessfulBuild lastSuccessfulBuildNumber isNil
]

{ #category : #tests }
PhLJenkins2JobTest >> testJobWithSuccessfulBuild [
	| job lastSuccessfulBuild |
	self setUpResponse: self oneBuildResponse.
	job := self newJobWithSuccessfulBuild.
	self assert: job builds size equals: 1.
	self assert: job builds first number equals: self lastSuccessfulBuildNumber.
	self assert: job lastSuccessfulBuildNumber equals: self lastSuccessfulBuildNumber.
	lastSuccessfulBuild := job lastSuccessfulBuild.
	self assert: lastSuccessfulBuild number equals: self lastSuccessfulBuildNumber.
	
	"This assertion makes sure the url of the lastSuccessfulBuild will always refer to the latest successful build."
	self assert: lastSuccessfulBuild url lastPathSegment equals: 'lastSuccessfulBuild'
]
