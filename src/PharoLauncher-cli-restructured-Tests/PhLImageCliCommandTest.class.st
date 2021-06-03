Class {
	#name : #PhLImageCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'model'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #instance }
PhLImageCliCommandTest >> PhLCliSpecificCommand [
	^ SubclassResponsibility 
]

{ #category : #adding }
PhLImageCliCommandTest >> addImageNamed: anImageName [
	^ model imageBaseRepository addImageNamed: anImageName
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
PhLImageCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #tests }
PhLImageCliCommandTest >> runCommand: args [
	| command  |
	" PhLCliCommand asCliCommand:model"
	command := PhLCliCommand asCliCommand: model.
	context := command activationWith: args.
	context execute.
	^ command
]

{ #category : #running }
PhLImageCliCommandTest >> setUp [
	super setUp.
	model := PharoLauncherCLIModel new.
	model imageBaseRepository: PhLImagesMockRepo new.

]
