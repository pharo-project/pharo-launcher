Class {
	#name : #PhLImageCreateFromPullRequestCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testExecuteFromPR [
	
	self runCommand: #('launcher' 'image' 'create' 'fromPR' '10849').
	self assert: self outputString equals: ''.
	self assert: (self errorString includesSubstring: '')
]
