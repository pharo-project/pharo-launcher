"
Abstraction of a yes/no dialog.
"
Class {
	#name : #PhLUIConfirmation,
	#superclass : #PhLUserInteraction,
	#instVars : [
		'message'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLUIConfirmation >> confirm [

	^ self application newConfirm 
		label: message;
		openModalWithParent: self relatedWindow
]

{ #category : #accessing }
PhLUIConfirmation >> message: aString [ 
	message := aString
]
