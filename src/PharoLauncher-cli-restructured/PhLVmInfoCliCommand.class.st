Class {
	#name : #PhLVmInfoCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmInfoCliCommand class >> asCliCommand [
		
	^ self newLauncherCommand: #info
]

{ #category : #'command line' }
PhLVmInfoCliCommand class >> launcherCmdDescription [

	^ 'Prints information about VM: name, remote-site URL, last update status, etc.'
]
