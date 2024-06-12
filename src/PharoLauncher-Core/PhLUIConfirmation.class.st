"
Abstraction of a yes/no dialog.
"
Class {
	#name : 'PhLUIConfirmation',
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
PhLUIConfirmation >> confirm [

	^ self application newConfirm 
		in: [ :this | 
			title ifNotNil: [ this title: title ] ];
		label: message;
		openModalWithParent: self relatedWindow
]

{ #category : 'accessing' }
PhLUIConfirmation >> message: aString [ 
	message := aString
]

{ #category : 'accessing' }
PhLUIConfirmation >> title: aString [
	
	title := aString
]
