"
I am a template that has already been downloaded in the past and stored somewhere on the disk.
"
Class {
	#name : #PhLLocalTemplate,
	#superclass : #PhLAbstractTemplate,
	#instVars : [
		'zipFile'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #serialization }
PhLLocalTemplate class >> fromSton: stonReader [
	| template |
	template := super fromSton: stonReader.
	template setName: template name zipFile: template zipArchive asFileReference.
	^ template

]

{ #category : #'instance creation' }
PhLLocalTemplate class >> name: aString zipFile: aFileReference [
	^ self new 
		setName: aString zipFile: aFileReference;
		yourself
		
]

{ #category : #comparing }
PhLLocalTemplate >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name 
		and: [ zipFile = anObject zipArchive ]
]

{ #category : #comparing }
PhLLocalTemplate >> hash [
	^ name hash bitXor: zipFile hash
]

{ #category : #testing }
PhLLocalTemplate >> isLocalTemplate [
	^ true
]

{ #category : #actions }
PhLLocalTemplate >> renameTo: aString [ 
	super renameTo: aString.
	zipFile renameTo: aString, '.zip'
]

{ #category : #'initialize-release' }
PhLLocalTemplate >> setName: aString zipFile: aFile [ 
	name := aString.
	zipFile := aFile
]

{ #category : #accessing }
PhLLocalTemplate >> url [
	^ ''
]

{ #category : #accessing }
PhLLocalTemplate >> zipArchive [
	^ zipFile
]
