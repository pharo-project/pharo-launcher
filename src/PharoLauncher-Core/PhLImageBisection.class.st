"
I represent a bisection algorithm on Pharo images that helps to find a faulty behavior.
I will do a dichotomic search of images, evaluating the condition block for each middle value.
- start image must evaluates to true (correct behavior)
- end image must evaluates to false (faulty behavior) 
"
Class {
	#name : #PhLImageBisection,
	#superclass : #Object,
	#instVars : [
		'evaluationBlock',
		'startIndex',
		'endIndex',
		'values'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLImageBisection class >> from: start to: end [
	^ self new
		from: start to: end;
		yourself
]

{ #category : #'instance creation' }
PhLImageBisection class >> on: values from: start to: end [
	^ self new
		on: values from: start to: end;
		yourself
]

{ #category : #private }
PhLImageBisection >> evaluateNext [

	| current result |
	current := self middle.
	result := evaluationBlock value: (values at: current).
	result
		ifTrue: [ startIndex := current ]
		ifFalse: [ endIndex := current ]
]

{ #category : #configuring }
PhLImageBisection >> evaluationBlock: aBlock [

	evaluationBlock := aBlock
]

{ #category : #accessing }
PhLImageBisection >> from: start to: end [

	self on: (start to: end) from: start to: end
]

{ #category : #configuring }
PhLImageBisection >> imageNameFor: buildNumber [
	
	^ 'image-', buildNumber
]

{ #category : #private }
PhLImageBisection >> middle [
	
	^ (startIndex to: endIndex) middle
]

{ #category : #accessing }
PhLImageBisection >> on: someValues from: startValue to: endValue [

	startValue > endValue ifTrue: [
		PhLImageBisectionError signal: 'start value must be lower than end value!' ].

	values := someValues.
	startIndex := values indexOf: startValue.
	endIndex := values indexOf: endValue
]

{ #category : #accessing }
PhLImageBisection >> result [
	
	[ endIndex - startIndex > 1 ] whileTrue: [ self evaluateNext ].
	^ values at: endIndex "first index evaluation to false after a true"
]
