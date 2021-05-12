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

	self application newInform 
		title: 'Error';
		label: message;
		openModalWithSpecParent: self application topWindow
]

{ #category : #action }
PhLUIInformation >> alert [

	self application newInform 
		title: 'Alert';
		label: message;
		openModalWithSpecParent: self application topWindow
]

{ #category : #action }
PhLUIInformation >> deny [

	self application newInform 
		title: 'Access Denied';
		label: message;
		openModalWithSpecParent: self application topWindow
]

{ #category : #action }
PhLUIInformation >> denyWithTitle: titleString [

	self application newInform 
		title: titleString;
		label: message;
		openModalWithSpecParent: self application topWindow
]

{ #category : #action }
PhLUIInformation >> inform [

	self application newInform 
		label: message;
		openModalWithSpecParent: self application topWindow
]

{ #category : #accessing }
PhLUIInformation >> message: aMessage [
	message := aMessage
]
