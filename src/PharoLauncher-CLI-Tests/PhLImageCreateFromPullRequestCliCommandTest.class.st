Class {
	#name : #PhLImageCreateFromPullRequestCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testExecuteFromPR [
	
	self runCommand: #('launcher' 'image' 'create' 'fromPR' '9588').
	self assert: (self errorString includesSubstring: '').
	self assert: (self outputString includesSubstring: 'PR-9588').
	
]
