"
A PhLDebugSampleCommand is provided simply as an example to assist users to learn how they might add their own commands to PharoLauncher.
"
Class {
	#name : #PhLDebugSampleCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Spec'
}

{ #category : #'as yet unclassified' }
PhLDebugSampleCommand class >> group [ 
	^99
]

{ #category : #'as yet unclassified' }
PhLDebugSampleCommand class >> title [
	^ 'Debug Sample Command'
]

{ #category : #action }
PhLDebugSampleCommand >> execute [
	"
	This is a deliberate halt left in production code to help users wanting to extend 
	the system to discover how commands are triggered. Now inspect the 'context'
	instance variable and define your operation on it.
	
	See PharoLauncher>>commandClassesForXXXX and senders for how to register commands.
	"
	
	Halt now.  
	
]

{ #category : #testing }
PhLDebugSampleCommand >> isApplicable [
	^ PhLDeploymentScript developmentEnvironmentEnabled
]
