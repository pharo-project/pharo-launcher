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
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLTemplateCategoriesCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	self addPrintFlagsTo: aCommandSpec.
]

{ #category : #'command line - converting' }
PhLTemplateCategoriesCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #categories 
]

{ #category : #'command line - description' }
PhLTemplateCategoriesCliCommand class >> launcherCmdDescription [

	^ 'Prints list of image template categories.'
]

{ #category : #'command execution' }
PhLTemplateCategoriesCliCommand >> basicExecute [

	[ self list: self templateRepository roots default: self defaultTemplateCategory ]
	on: NotFound 
	do: [ self list: self templateRepository roots ]
]

{ #category : #private }
PhLTemplateCategoriesCliCommand >> modelClass [ 

	^ self class environment at: #PhLCacheTemplateGroup
]
