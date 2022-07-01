"
I represent mock class for create image from PR
"
Class {
	#name : #PhLImageCreateFromPullRequestCliCommandMock,
	#superclass : #PhLImageCreateFromPullRequestCliCommand,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #'private - testing' }
PhLImageCreateFromPullRequestCliCommandMock class >> isProductionCommandClass [

	"this command class not exposed for user to be visible in CLI"
	^ false
]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommandMock >> context [

	^ context
]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommandMock >> context: anObject [

	context := anObject
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommandMock >> imageFinderFromPullRequest [
	
	"use stub image finder instead"
	^  PhLImageFinderStub fromInriaCIPullRequest: self pullRequestNumber
]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommandMock >> imageName [

	^ self implicitImageName 
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommandMock >> outStream [
	^ outStream
		ifNil: [ outStream := VTermOutputDriver on: self context stdout ]
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromPullRequestCliCommandMock >> pullRequestNumber [

	^ '10553'
]
