"
I represent a template that is somewhere on the network.
"
Class {
	#name : #PhLRemoteTemplate,
	#superclass : #PhLAbstractTemplate,
	#instVars : [
		'url'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #example }
PhLRemoteTemplate class >> example [ 
	^ self name: 'Pharo Mooc' url: 'https://mooc.pharo.org/image/PharoWeb.zip'
]

{ #category : #'instance creation' }
PhLRemoteTemplate class >> name: aString shortName: shortNameString url: anUrl username: anotherString password: yetAnotherString [
	^ (self name: aString url: anUrl)
		  shortName: shortNameString;
		  username: anotherString;
		  password: yetAnotherString;
		  yourself
]

{ #category : #'instance creation' }
PhLRemoteTemplate class >> name: aString url: anUrl [
	^ self new
		setName: aString url: anUrl;
		yourself
]

{ #category : #'instance creation' }
PhLRemoteTemplate class >> name: aString url: anUrl username: anotherString password: yetAnotherString [
	^ self name: aString shortName: nil url: anUrl username: anotherString password: yetAnotherString
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

{ #category : #accessing }
PhLRemoteTemplate >> password [
	^ url password
]

{ #category : #accessing }
PhLRemoteTemplate >> password: aString [
	url password: aString
]

{ #category : #initialization }
PhLRemoteTemplate >> setName: aName url: anUrl [
	name := aName.
	url := anUrl
]

{ #category : #querying }
PhLRemoteTemplate >> suggestedImageName [
	| rxMatcher |
	rxMatcher := '(\((\w+).zip\)).*' asRegex.
	^ (rxMatcher matches: self name)
		ifTrue: [ rxMatcher subexpression: 3 "extract zip filename" ]
		ifFalse: [ self name ]
]

{ #category : #accessing }
PhLRemoteTemplate >> url [
	^ url
]

{ #category : #accessing }
PhLRemoteTemplate >> username [
	^ url username
]

{ #category : #accessing }
PhLRemoteTemplate >> username: aString [
	url username: aString
]

{ #category : #accessing }
PhLRemoteTemplate >> zipArchive [
	"The local template group takes care of cashing downloaded templates."

	^ PhLDownloadedTemplateGroup default downloadAndStoreFile: url forTemplate: self
]
