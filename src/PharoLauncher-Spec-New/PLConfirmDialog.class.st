Class {
	#name : #PLConfirmDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'messageLabel'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #convenience }
PLConfirmDialog class >> confirmMessage: aString [

	^ (self new
		message: aString;
		openModalWithSpec)
		isOk
]

{ #category : #convenience }
PLConfirmDialog class >> confirmTitle: titleString Message: aString [

	^ (self new
		title: titleString;
		message: aString;
		openModalWithSpec)
		isOk
]

{ #category : #specs }
PLConfirmDialog class >> defaultSpec [

	^ SpecBoxLayout newVertical
		borderWidth: 10;
		add: #messageLabel;
		yourself
]

{ #category : #initialization }
PLConfirmDialog >> initialize [ 

	super initialize.
	self title: 'Confirm'
]

{ #category : #initialization }
PLConfirmDialog >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter
		addButton: 'Cancel' do: #close;
		addButton: 'Accept' do: [ :presenter |  presenter beOk; close ]
]

{ #category : #initialization }
PLConfirmDialog >> initializeWidgets [
	
	messageLabel := self newLabel
]

{ #category : #initialization }
PLConfirmDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: self title;
		initialExtent: 400@120
]

{ #category : #accessing }
PLConfirmDialog >> message: aString [

	messageLabel label: aString
]
