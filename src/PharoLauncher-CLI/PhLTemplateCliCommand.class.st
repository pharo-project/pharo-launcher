"
I represent Pharo Template sub-command of Pharo Launcher. My responsibility is to take care of Pharo template sub-commands. 

I use: 
 - Pharo launcher root command to declare my other sub-commands.

I declare: 
- categories, list, sourcesDir, sourcesUrl sub-commands

I execute:
- just printing help about my sub-commands relevant for Pharo templates
"
Class {
	#name : #PhLTemplateCliCommand,
	#superclass : #PhLCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLTemplateCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #template 
]

{ #category : #'command line - description' }
PhLTemplateCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to image templates.'
]

{ #category : #private }
PhLTemplateCliCommand >> modelClass [

 ^ self class environment at: #PhLAbstractTemplate 
]
