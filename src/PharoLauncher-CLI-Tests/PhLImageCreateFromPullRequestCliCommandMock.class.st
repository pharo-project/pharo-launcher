"
I represent mock class for create image from PR
"
Class {
	#name : #PhLImageCreateFromPullRequestCliCommandMock,
	#superclass : #PhLImageCreateFromPullRequestCliCommand,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #'private - testing' }
PhLImageCreateFromPullRequestCliCommandMock class >> isProductionCommandClass [

	"this command class not exposed for user to be visible in CLI"
	^ false
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommandMock >> imageFinderClass [ 
	
	^ PhLImageFinderStub 
]
