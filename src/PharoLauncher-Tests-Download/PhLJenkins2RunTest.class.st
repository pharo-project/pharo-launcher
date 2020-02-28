Class {
	#name : #PhLJenkins2RunTest,
	#superclass : #PhLJenkins2EntityTest,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #'instance creation' }
PhLJenkins2RunTest class >> newInstance [
	| job |
	job := PhLJenkins2Run
		newWithProperties: (STONJSON fromString: '{"url":"https://ci.inria.fr/pharo-contribution/job/MaterialDesignLite/PHARO=61,VERSION=development/1140/","number":1140}').
	job parent: PhLJenkins2BuildTest newInstance.
	^ job
]

{ #category : #'instance creation' }
PhLJenkins2RunTest class >> newSecureJenkinsInstance [
	| job |
	job := PhLJenkins2Run
		newWithProperties: (STONJSON fromString: '{"url":"https://ci.inria.fr/pharo-contribution/job/MaterialDesignLite/PHARO=61,VERSION=development/1140/","number":1140}').
	job parent: PhLJenkins2BuildTest newSecureJenkinsInstance.
	^ job
]
