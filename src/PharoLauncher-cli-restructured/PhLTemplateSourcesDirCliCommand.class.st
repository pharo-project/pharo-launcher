Class {
	#name : #PhLTemplateSourcesDirCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLTemplateSourcesDirCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #sourcesDir
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> execute [
   self outputSourcesDirectoryTemplate.
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> initialize [
   repository := PhLTemplateGroupRepository default.
	stream := VTermOutputDriver stdout.
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> outputSourcesDirectoryTemplate [
   stream nextPutAll: repository localTemplatesDirectory asString. stream cr. 
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> repository: aPhLMockTemplatesRepository [
	repository := aPhLMockTemplatesRepository
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream 
]
