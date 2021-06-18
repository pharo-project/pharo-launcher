Class {
	#name : #PhLNotificationCenter,
	#superclass : #Object,
	#instVars : [
		'clapContext',
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
PhLNotificationCenter >> clapContext [
	^ clapContext 
]

{ #category : #accessing }
PhLNotificationCenter >> clapContext: aClapContext [
	clapContext := aClapContext  
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
