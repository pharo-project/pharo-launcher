Class {
	#name : #PhLImageCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #adding }
PhLImageCliCommandTest >> addImageNamed: anImageName [
	^ self imageRepository addImageNamed: anImageName
]

{ #category : #asserting }
PhLImageCliCommandTest >> assertFailure [
	self deny: context exitStatus equals: 0
]

{ #category : #accessing }
PhLImageCliCommandTest >> assertSuccess [
	self assert: context exitStatus equals: 0.
	self assert: self errorString equals: ''
]

{ #category : #accessing }
PhLImageCliCommandTest >> errorString [
	^ context stdio stderr contents utf8Decoded
]

{ #category : #accessing }
PhLImageCliCommandTest >> imageRepository [ 
	^ self launcherModel imageBaseRepository
]

{ #category : #accessing }
PhLImageCliCommandTest >> launcherModel [
	^ context launcherModel 
]

{ #category : #accessing }
PhLImageCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #tests }
PhLImageCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]

{ #category : #running }
PhLImageCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model imageBaseRepository: PhLImagesMockRepo new.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model

]
