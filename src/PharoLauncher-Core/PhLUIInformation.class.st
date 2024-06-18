"
Abstraction of an information dialog.
"
Class {
	#name : 'PhLUIInformation',
	#superclass : 'PhLUserInteraction',
	#instVars : [
		'message',
		'title'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'action' }
PhLUIInformation >> abort [

	self application newInform 
		title: 'Error';
		label: message;
		openModalWithParent: self relatedWindow
]

{ #category : 'action' }
PhLUIInformation >> alert [

	self application newInform 
		title: 'Alert';
		label: message;
		openModalWithParent: self relatedWindow
]

{ #category : 'action' }
PhLUIInformation >> deny [

	self application newInform 
		title: 'Access Denied';
		label: message;
		openModalWithParent: self relatedWindow
]

{ #category : 'action' }
PhLUIInformation >> denyWithTitle: titleString [

	self application newInform 
		title: titleString;
		label: message;
		openModalWithParent: self relatedWindow
]

{ #category : 'action' }
PhLUIInformation >> inform [

	self application newInform 
		in: [ :this | title ifNotNil: [ this title: title ] ];
		label: message;
		openModalWithParent: self relatedWindow
]

{ #category : 'accessing' }
PhLUIInformation >> message: aMessage [
	message := aMessage
]

{ #category : 'accessing' }
PhLUIInformation >> title: aString [ 
	
	title := aString
]
