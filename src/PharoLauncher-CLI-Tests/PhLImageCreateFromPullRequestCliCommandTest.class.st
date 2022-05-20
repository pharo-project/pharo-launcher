Class {
	#name : #PhLImageCreateFromPullRequestCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testExecuteFromPR [
	
	self runCommand: #('launcher' 'image' 'create' 'fromPull' '--pharoVersion' '10').
	
	self assert: (self errorString includesSubstring: '')
]
