Class {
	#name : #PhLNotificationCenter,
	#superclass : #Object,
	#instVars : [
		'outStream',
		'errorStream'
	],
	#classVars : [
		'Default'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #accessing }
PhLNotificationCenter class >> default [ 
	^ Default ifNil: [ Default := self new ]
]

{ #category : #accessing }
PhLNotificationCenter >> errorStream [
	^ errorStream 
]

{ #category : #accessing }
PhLNotificationCenter >> errorStream: anErrorStream [
	errorStream := anErrorStream
]

{ #category : #accessing }
PhLNotificationCenter >> outStream [
	^ outStream 
]

{ #category : #accessing }
PhLNotificationCenter >> outStream: anOutStream [
	outStream := anOutStream 
]
