"
I'm used to simulate a launch of an image in Tests.
I run a command (external process) that will run fast on the Operating System to keep tests running fast.
"
Class {
	#name : #PhLTestLaunchConfiguration,
	#superclass : #PhLLaunchConfiguration,
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #querying }
PhLTestLaunchConfiguration >> command [	
	"dummy call, only requirement is that the command is available on supported Operating Systems."

	^ OSPlatform current isWindows 
		ifTrue: [ 'cd' ] 
		ifFalse: [ 'true' ]
]

{ #category : #querying }
PhLTestLaunchConfiguration >> launchProcess [

	^ PhLProcessWrapper new
		  command: self command;
		  yourself
]
