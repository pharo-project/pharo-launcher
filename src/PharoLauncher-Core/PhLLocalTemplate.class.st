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

{ #category : #'instance creation' }
PhLLocalTemplate class >> name: aString zipFile: aFileReference [
	^ self new 
		setName: aString zipFile: aFileReference;
		yourself
		
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
