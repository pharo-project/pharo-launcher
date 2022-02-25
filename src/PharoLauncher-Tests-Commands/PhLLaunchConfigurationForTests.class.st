"
My only current user is PhLLaunchImageCommandTest.

I am a subclass of PhLLaunchConfiguration which allows to avoid launching a real running process for an image.
"
Class {
	#name : #PhLLaunchConfigurationForTests,
	#superclass : #PhLLaunchConfiguration,
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #querying }
PhLLaunchConfigurationForTests >> launchProcess [ 
	"dummy call, only requirement is that the command is portable"
	^ PhLProcessWrapper new command: 'cd' ; yourself
]
