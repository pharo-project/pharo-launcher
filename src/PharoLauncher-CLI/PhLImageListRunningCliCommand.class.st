Class {
	#name : #PhLImageListRunningCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageListRunningCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #listRunning 
]

{ #category : #'command line' }
PhLImageListRunningCliCommand class >> launcherCmdDescription [

	^ 'Lists all running images on local computer.'
]

{ #category : #'command execution' }
PhLImageListRunningCliCommand >> execute [
   LibC runCommand: 'ps -aux | grep -i Pharo | grep image'
]
