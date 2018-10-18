"
I represent a template that is somewhere on the network.
"
Class {
	#name : #PhLRemoteTemplate,
	#superclass : #PhLAbstractTemplate,
	#instVars : [
		'url'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLRemoteTemplate class >> name: aString url: anUrl [
	^ self new
		setName: aString url: anUrl;
		yourself
]

{ #category : #'initialize-release' }
PhLRemoteTemplate >> setName: aName url: anUrl [
	name := aName.
	url := anUrl
]

{ #category : #accessing }
PhLRemoteTemplate >> url [
	^ url
]

{ #category : #accessing }
PhLRemoteTemplate >> zipArchive [
	"The local template group takes care of cashing downloaded templates."
	^ PhLDownloadedTemplateGroup default downloadAndStoreFile: url forTemplate: self
]
