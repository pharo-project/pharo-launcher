Class {
	#name : #PhLTemplateListCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#instVars : [
		'repository',
		'stream'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLTemplateListCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #list
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> execute [
   self outputListTemplates.
]

{ #category : #initialization }
PhLTemplateListCliCommand >> initialize [
   repository := PhLTemplateGroupRepository default.
	stream := VTermOutputDriver stdout.
]

{ #category : #initialization }
PhLTemplateListCliCommand >> outputListTemplates [

	repository localTemplateNames
		do: [ :aTemplate | stream nextPutAll: aTemplate asString. stream cr. ]
]

{ #category : #initialization }
PhLTemplateListCliCommand >> repository: aPhLMockTemplatesRepository [
	repository := aPhLMockTemplatesRepository
]

{ #category : #initialization }
PhLTemplateListCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
