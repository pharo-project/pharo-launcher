Class {
	#name : #PhLImageCreateFromPullRequestCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testExecuteFromPR [
	
	|mockCommand|
	mockCommand := PhLImageCreateFromPullRequestCliCommandMock new.
	mockCommand context: context.
	mockCommand execute.
	self assert: (self errorString includesSubstring: '').
	self assert: (self outputString includesSubstring: 'PR-10553').
	
]
