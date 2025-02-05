Class {
	#name : 'ConsoleProgressBarTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-CLI-Tests-Others',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Others'
}

{ #category : 'tests' }
ConsoleProgressBarTest >> testCanDisplayProgress [
	| bar result |
	result := String streamContents: [ :stream |
		bar := ConsoleProgressBar on: stream. 
		bar value: 20. ].
	
	self assert: result equals: '[##        ] 20%' , OSPlatform current lineEnding 
	
	
]

{ #category : 'tests' }
ConsoleProgressBarTest >> testCannotDisplayProgressAbove100Percent [
	| bar result |
	result := String streamContents: [ :stream |
		bar := ConsoleProgressBar on: stream. 
		bar value: 120. ].
	
	self assert: result equals: '[##########] 100%' , OSPlatform current lineEnding 
	
	
]

{ #category : 'tests' }
ConsoleProgressBarTest >> testShouldNotRaiseErrorWhenDisplayingProgressAndNoOutStream [
	| bar |
	bar := ConsoleProgressBar on: nil. 
	bar value: 20
]
