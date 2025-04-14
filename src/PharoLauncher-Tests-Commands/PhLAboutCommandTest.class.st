Class {
	#name : 'PhLAboutCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
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

{ #category : 'accessing' }
PhLAboutCommandTest >> window [
	"In a non-testing environment this message will be send to a SpWindowPresenter"
	^ nil
]
