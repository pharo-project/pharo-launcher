Class {
	#name : #Uselessbutcantdeleteit,
	#superclass : #PhLTemplateGroupRepository,
	#instVars : [
		'templates'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #initialization }
Uselessbutcantdeleteit >> initialize [
	self model: (PhLTemplateGroupTestRepository new).
	self application: (PharoLauncherApplication new
		scriptsDirectory: FileSystem memory root;
		yourself).
	templates := OrderedCollection new.
	
	super initialize.
]
