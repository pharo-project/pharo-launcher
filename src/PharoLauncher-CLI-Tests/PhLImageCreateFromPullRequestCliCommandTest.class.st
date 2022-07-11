Class {
	#name : #PhLImageCreateFromPullRequestCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testExecuteFromPR [
	
	|mockCommand aMatch|
	
	aMatch := (context arguments: #('launcher' 'image' 'create' 'fromPR' '10553')) doMatch.
	aMatch := ((aMatch at: #image) at: #create) at: #fromPR.

	mockCommand := PhLImageCreateFromPullRequestCliCommandMock new.
	mockCommand setArguments: aMatch.

	mockCommand execute.

	self assert: (self errorString includesSubstring: '').
	self assert: (self outputString includesSubstring: 'PR-10553').
	
]
