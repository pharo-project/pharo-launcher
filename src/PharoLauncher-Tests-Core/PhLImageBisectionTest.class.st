Class {
	#name : #PhLImageBisectionTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLImageBisectionTest >> testDichotomy [
	| bisect testedIndexes result |
	testedIndexes := OrderedCollection new.
	bisect := PhLImageBisection from: 1 to: 20.
	bisect evaluationBlock: [ :index | testedIndexes add: index. index < 8 ].
	
	result := bisect result.
	
	self 
		assertCollection: testedIndexes
		hasSameElements: #(11 6 9 8 7).
	self assert: result equals: 8
]

{ #category : #tests }
PhLImageBisectionTest >> testDichotomyWithMissingValues [
	| bisect testedIndexes result |
	testedIndexes := OrderedCollection new.
	bisect := PhLImageBisection on: #(1 3 4 7 10 11 12 15 17 20) from: 1 to: 20.
	bisect evaluationBlock: [ :index | testedIndexes add: index. index < 8 ].
	
	result := bisect result.
	
	self 
		assertCollection: testedIndexes
		hasSameElements: #(11 7 10).
	self assert: result equals: 10
]

{ #category : #tests }
PhLImageBisectionTest >> testGetExceptionWhenStartIsBiggerThanEnd [

	self
		should: [ PhLImageBisection from: 9 to: 0 ]
		raise: PhLImageBisectionError
]

{ #category : #tests }
PhLImageBisectionTest >> testGetFirstValueEvaluatingToFalse [

	| bisect |
	bisect := PhLImageBisection from: 1 to: 20.
	bisect evaluationBlock: [ :index | index < 8 ].
	
	self assert: bisect result equals: 8.
]

{ #category : #tests }
PhLImageBisectionTest >> testGetStartIndexWhenStartAndEndHaveSameValue [

	| bisect |
	bisect := PhLImageBisection from: 8 to: 8.
	bisect evaluationBlock: [ :index | index = 8 ].
	
	self assert: bisect result equals: 8.
]
