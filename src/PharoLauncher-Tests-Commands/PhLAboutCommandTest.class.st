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
	super tearDown.
	presenter window close
]

{ #category : #tests }
PhLAboutCommandTest >> testCanOpenAboutDialog [
	| command |
	command := PhLAboutCommand2 new.
	
	presenter := command execute.

	self assert: (presenter description text includesSubstring: 'Pharo Launcher')
]
