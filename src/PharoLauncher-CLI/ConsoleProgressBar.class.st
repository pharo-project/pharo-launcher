"
You can use me to display the progress of a specific task.
I maintain the current progression and print on my out stream if there is a change in the progression.
"
Class {
	#name : #ConsoleProgressBar,
	#superclass : #Object,
	#instVars : [
		'value',
		'outStream'
	],
	#category : #'PharoLauncher-CLI-Utility'
}

{ #category : #'instance creation' }
ConsoleProgressBar class >> on: aWriteStream [ 
	^ self new 
		stream: aWriteStream;
		yourself
]

{ #category : #displaying }
ConsoleProgressBar >> displayProgress: percentage [
	| increment |
	self outStream ifNil: [ ^ self ].
	
	self outStream nextPut: $[.
	increment := self value // 10.
	increment timesRepeat: [ self outStream nextPut: $# ].
	(10 - increment) timesRepeat: [ self outStream nextPut: Character space ].
	self outStream 
		nextPutAll: '] ';
		print: self value asInteger;
		nextPut: $%;
		nextPutAll: OSPlatform current lineEnding.
]

{ #category : #initialization }
ConsoleProgressBar >> initialize [ 
	super initialize.
	value := 0.
]

{ #category : #accessing }
ConsoleProgressBar >> maxValue [
	^ 100
]

{ #category : #accessing }
ConsoleProgressBar >> outStream [
	^ outStream
]

{ #category : #initialization }
ConsoleProgressBar >> stream: aWriteStream [ 
	outStream := aWriteStream
]

{ #category : #'job subscription' }
ConsoleProgressBar >> updateJob: aJobChange [
	self value: aJobChange percentage asInteger
]

{ #category : #accessing }
ConsoleProgressBar >> value [ 
	^ value
]

{ #category : #accessing }
ConsoleProgressBar >> value: aValue [
	aValue > self value 
		ifTrue: [ value := aValue min: self maxValue. self displayProgress: value ]
]
