"
I represent Pharo Image sub-command of Pharo Launcher. My responsibility is to take care of Pharo image sub-commands. 

I use: 
 - Pharo launcher root command to declare my other sub-commands.

I declare: 
- copy, create, delete, info initScriptsDir, launch, list, update sub-commands

I execute:
- just printing help about my sub-commands relevant for Pharo images
"
Class {
	#name : #PhLImageCliCommand,
	#superclass : #PhLCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #image launcherModel: aPharoLauncherModel
]

{ #category : #'command line' }
PhLImageCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to management of local Pharo images.'
]

{ #category : #accessing }
PhLImageCliCommand >> findImage: anImageName [
	^ self pharoLauncherModel imageBaseRepository imageNamed: anImageName asLowercase. 
]
