Class {
	#name : #PhLImageCreateFromPullRequestCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testExecuteFromPR [

	self flag: 'How to fake PR from Inria CI?'.
	
	self runCommand: #('launcher' 'image' 'create' 'fromPR' '9588').
	self assertSuccess.
	self assert: (self outputString includesSubstring: 'PR-9588').
	
]
