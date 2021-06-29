"
Abstraction of an information dialog.
"
Class {
	#name : #PhLUIInformation,
	#superclass : #PhLUserInteraction,
	#instVars : [
		'message'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLUIInformation >> abort [
	UIManager default abort: message
]

{ #category : #action }
PhLUIInformation >> alert [
	UIManager default alert: message
]

{ #category : #action }
PhLUIInformation >> deny [
	UIManager default deny: message
]

{ #category : #action }
PhLUIInformation >> denyWithTitle: titleString [
	UIManager default deny: message title: titleString
]

{ #category : #action }
PhLUIInformation >> inform [
	UIManager inform: message
]

{ #category : #accessing }
PhLUIInformation >> message: aMessage [
	message := aMessage
]
