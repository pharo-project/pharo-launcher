Class {
	#name : #PhLImageCreateFromPullRequestCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testExecuteFromPR [

	| command |

	command := (context arguments: #('launcher' 'image' 'create' 'fromPR' '9588')) command.
	command imageFinderClass: PhLImageFinderStub.
	
	command execute.
	
	self assert: self errorString isEmpty.
	self assert: (self outputString includesSubstring: 'PR-9588').
  
]

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testInvalidPRShouldGiveError [

	self runCommand: #('launcher' 'image' 'create' 'fromPR' 'someNoise123' ).
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Not a valid pull request number').
	
]

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testMissingPRShouldGiveError [

	self runCommand: #('launcher' 'image' 'create' 'fromPR').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'specify the pull request number').
	
]

{ #category : #tests }
PhLImageCreateFromPullRequestCliCommandTest >> testUnreachablePRShouldGiveError [

	self runCommand: #('launcher' 'image' 'create' 'fromPR' '99999999999999' ).
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Could not determine build artifact for pull request').
	
]
