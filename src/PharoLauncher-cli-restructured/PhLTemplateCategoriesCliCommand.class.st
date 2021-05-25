Class {
	#name : #PhLTemplateCategoriesCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#instVars : [
		'repository',
		'stream'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLTemplateCategoriesCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #categories
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> execute [
   self outputTemplateCategories.
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> initialize [
   repository := PhLTemplateGroupRepository default.
	stream := VTermOutputDriver stdout.
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> outputTemplateCategories [
	| listTemplatesAvailableForDownload |
   listTemplatesAvailableForDownload := repository roots. 
   listTemplatesAvailableForDownload do: [ :category | stream nextPutAll: category asString; lf. ]
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> repository: aPhLMockTemplatesRepository [
	repository := aPhLMockTemplatesRepository
]

{ #category : #initialization }
PhLTemplateCategoriesCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
