Class {
	#name : #PhLImageInitScriptsDirCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageInitScriptsDirCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #initScriptDir
]

{ #category : #'command line' }
PhLImageInitScriptsDirCliCommand class >> launcherCmdDescription [

	^ 'Prints, sets directory path, where init scripts for images are located.'
]
