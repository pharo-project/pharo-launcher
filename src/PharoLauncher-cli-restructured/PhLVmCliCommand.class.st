Class {
	#name : #PhLVmCliCommand,
	#superclass : #PhLCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #vm launcherModel: aPharoLauncherModel
]

{ #category : #'command line' }
PhLVmCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to VM management.'
]
