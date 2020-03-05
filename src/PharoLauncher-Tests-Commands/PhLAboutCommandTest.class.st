Class {
	#name : #PhLAboutCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLAboutCommandTest >> tearDown [
	presenter window close.
	super tearDown
]

{ #category : #tests }
PhLAboutCommandTest >> testCanOpenAboutDialog [
	| command |
	command := PhLAboutCommand new.
	
	presenter := command execute.

	self assert: (presenter description text includesSubstring: 'Pharo Launcher')
]
