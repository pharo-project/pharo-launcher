Class {
	#name : #PhLTemplateSourcesUrlCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLTemplateSourcesUrlCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #sourcesUrl
]

{ #category : #initialization }
PhLTemplateSourcesUrlCliCommand >> execute [
   self outputSourcesUrlTemplate.
]

{ #category : #accessing }
PhLTemplateSourcesUrlCliCommand >> initialize [
   repository := PhLTemplateGroupRepository default.
	stream := VTermOutputDriver stdout.
]

{ #category : #initialization }
PhLTemplateSourcesUrlCliCommand >> outputSourcesUrlTemplate [
	| listTemplatesAvailableForDownload |
   listTemplatesAvailableForDownload := PhLTemplateGroupRepository default roots. 
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload  detect: [:aGroup | aGroup name = 'Official distributions'  ].
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload children.
   listTemplatesAvailableForDownload do: [ :template | stream nextPutAll: template name.stream nextPutAll:': '.stream nextPutAll: (template url asString ). stream lf ]
]

{ #category : #accessing }
PhLTemplateSourcesUrlCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
