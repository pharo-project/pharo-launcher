Class {
	#name : #PhLVmListCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmListCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #list
]

{ #category : #'command line' }
PhLVmListCliCommand class >> launcherCmdDescription [

	^ 'Lists all available VMs, with status.'
]
