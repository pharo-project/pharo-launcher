Class {
	#name : #PhLFileBrowserTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLFileBrowserTest >> testCanOpenAFileBrowserOnImageFolder [
	| path |
	path := Smalltalk image imageDirectory fullName.
	PhLFileBrowser openOn: path.
]
