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

{ #category : #'as yet unclassified' }
PhLRemoteTemplate class >> example [ 
	^ self name: 'Pharo Mooc' url: 'https://mooc.pharo.org/image/PharoWeb.zip'
]

{ #category : #'instance creation' }
PhLRemoteTemplate class >> name: aString url: anUrl [
	^ self new
		setName: aString url: anUrl;
		yourself
]

{ #category : #comparing }
PhLRemoteTemplate >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name 
		and: [ url = anObject url ]
]

{ #category : #comparing }
PhLRemoteTemplate >> hash [
	^ name hash bitXor: url hash
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
