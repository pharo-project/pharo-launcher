Class {
	#name : #PhLImageFinderTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #accessing }
PhLImageFinderTest class >> defaultTimeLimit [
	^ 300 seconds
]

{ #category : #tests }
PhLImageFinderTest >> testCreateImageFromABuildOfATemplateForPharo8ShouldReturnGoodURL [
	| finder |
	finder := PhLImageFinder pharoVersion: '8' build: '210'.
	self
		assert: finder findUrl
		equals:
			'https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.210.sha.5da933e.arch.64bit.zip'
]

{ #category : #tests }
PhLImageFinderTest >> testCreateImageFromABuildOfATemplateForPharo9ShouldReturnGoodURL [
	| finder |
	
	finder := PhLImageFinder pharoVersion: '9' build:'300'.
	self assert: finder findUrl equals: 'https://files.pharo.org/image/90/Pharo9.0-SNAPSHOT.build.300.sha.b315fa8.arch.64bit.zip'
	
]

{ #category : #tests }
PhLImageFinderTest >> testShouldFindUrlWhenPharo10AndValidBuildNumberProvided [
	| finder |
	
	finder := PhLImageFinder pharoVersion: '10' build: '21'.
	self assert: finder findUrl equals: 'https://files.pharo.org/image/100/Pharo10-SNAPSHOT.build.21.sha.f022266.arch.64bit.zip'  
]

{ #category : #tests }
PhLImageFinderTest >> testShouldFindUrlWhenPharo7AndValidBuildNumberProvided [
	| finder |
	
	finder := PhLImageFinder pharoVersion: '7' build:'510'.
	self assert: finder findUrl equals: 'https://files.pharo.org/image/70/Pharo-7.0.0-alpha.build.510.sha.fb39ee7.arch.64bit.zip'

]

{ #category : #tests }
PhLImageFinderTest >> testShouldRaiseNotFoundWhenInvalidBuildNumberProvided [

	self
		should: [ (PhLImageFinder pharoVersion: '10' build: '-21') findUrl ]	
		raise: NotFound

]

{ #category : #tests }
PhLImageFinderTest >> testShouldRaiseNotFoundWhenInvalidPharoVersionProvided [

	self
		should: [ (PhLImageFinder pharoVersion: '900' build: '21') findUrl ]	
		raise: NotFound

]

{ #category : #tests }
PhLImageFinderTest >> testShouldRaiseNotFoundWhenInvalidShaProvided [

	self
		should: [ (PhLImageFinder pharoVersion: '10' sha: 'abcde') findUrl ]	
		raise: NotFound

]
