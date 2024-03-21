Class {
	#name : #PhLLaunchedImagesWatcherTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Debug'
}

{ #category : #tests }
PhLLaunchedImagesWatcherTest >> testCanCatchProcessError [
	| process image |
	process := PhLProcessWrapper new
		command: '/bin/ls';
		addArgument: '/foo/bar';
		yourself.
	image := PhLImage location: FileSystem memory root.
	
	process runUnwatch.
	
	self
		should:
			[ (PhLLaunchedImagesWatcher process: process image: image) basicCheckProcess ]
		raise: PhLLaunchError
]

{ #category : #tests }
PhLLaunchedImagesWatcherTest >> testProcessSuccessfulDoesNotThrowError [
	| process image |
	process := PhLProcessWrapper new
		command: '/bin/ls';
		yourself.
	image := PhLImage location: FileSystem memory root.
	
	process runUnwatch.
	
	self
		shouldnt:
			[ (PhLLaunchedImagesWatcher process: process image: image) basicCheckProcess ]
		raise: PhLLaunchError
]
