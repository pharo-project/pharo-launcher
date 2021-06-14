"
I represent Pharo Template categories sub-command invoked from cmd line of Pharo Launcher. My responsibility is to list templates categories. 

I declare: 
- optional flag for stonOutput

I execute:
- list different templates categories.
"
Class {
	#name : #PhLTemplateCategoriesCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLTemplateCategoriesCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #categories 
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> execute [
	| counter |
	counter := 1.
	self templateRepository roots
		do: [ :category | 
			self outStream
				nextPutAll: counter asString;
				nextPutAll: ' ';
				nextPutAll: category asString;
				newLine.
			counter := counter + 1 ]
]
