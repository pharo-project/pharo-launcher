Class {
	#name : 'PhLAboutCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core-Move-From-Commands',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'Move-From-Commands'
}

{ #category : 'accessing' }
PhLAboutCommandTest >> application [
    ^ SpMockApplication new
]

{ #category : 'running' }
PhLAboutCommandTest >> tearDown [
	presenter window 
		ifNotNil: [ :window | window close].
	super tearDown
]

{ #category : 'tests' }
PhLAboutCommandTest >> testCanOpenAboutDialog [
	| command |
	command := PhLAboutCommand forContext: self.
	
	presenter := command execute.

	self assert: (presenter description text includesSubstring: 'Pharo Launcher')
]
