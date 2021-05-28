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
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLTemplateCategoriesCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #categories launcherModel: aPharoLauncherModel
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> execute [
   self outputTemplateCategories.
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> outputTemplateCategories [
	| listTemplatesAvailableForDownload |
   listTemplatesAvailableForDownload := self pharoLauncherModel templateBaseRepository roots. 
   listTemplatesAvailableForDownload do: [ :category | self outStream nextPutAll: category asString; lf. ]
]
