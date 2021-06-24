Class {
	#name : #PhLCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #asserting }
PhLCliCommandTest >> assertFailure [
	self deny: context exitStatus equals: 0
]

{ #category : #asserting }
PhLCliCommandTest >> assertSuccess [
	self assert: context exitStatus equals: 0.
	self assert: self errorString equals: ''
]

{ #category : #accessing }
PhLCliCommandTest >> errorString [
	^ context stdio stderr contents utf8Decoded
]

{ #category : #accessing }
PhLCliCommandTest >> launcherModel [
	^ context launcherModel 
]

{ #category : #accessing }
PhLCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #'process actions' }
PhLCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]
