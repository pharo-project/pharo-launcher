Class {
	#name : #PhLTemplatesCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> assertSuccess [
	self assert: context exitStatus equals: 0.
	self assert: self errorString equals: ''
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> errorString [
	^ context stdio stderr contents utf8Decoded
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> launcherModel [
	^ context launcherModel 
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]

{ #category : #tests }
PhLTemplatesCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model templateBaseRepository: PhLTemplateGroupTestRepository new.
	model templateBaseRepository createLocalTemplateNamed:'foo'.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> templateRepository [ 
	^ self launcherModel templateBaseRepository
]
