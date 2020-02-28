Class {
	#name : #PhLJenkins2RunTest,
	#superclass : #PhLJenkins2EntityTest,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #'instance creation' }
PhLJenkins2RunTest class >> newInstance [
	^ self newWithoutParent
		  parent: PhLJenkins2BuildTest newInstance;
		  yourself
]

{ #category : #'instance creation' }
PhLJenkins2RunTest class >> newSecureInstance [
	^ self newWithoutParent
		  parent: PhLJenkins2BuildTest newSecureInstance;
		  yourself
]

{ #category : #'instance creation' }
PhLJenkins2RunTest class >> newWithoutParent [
	^ PhLJenkins2Run newWithProperties: (STONJSON fromString:
			   '{"url":"https://ci.inria.fr/pharo-contribution/job/MaterialDesignLite/PHARO=61,VERSION=development/1140/","number":1140}')
]
