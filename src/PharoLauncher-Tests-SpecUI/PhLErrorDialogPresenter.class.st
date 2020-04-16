"
A small presenter to catch errors and present them nicely to the user.
I provide an acknowledge button ('ok') and a debug button that will open the Pharo debugger.

To use me, install me as the default debugger tool.
I use GTGenericStackDebugger debugger as default.

To try me:

currentDebugger := Smalltalk tools debugger.
Smalltalk tools debuggerTool: PhLErrorDialogPresenter.
[ NotFound signal: 'foo'.
	self inform: 'execution not aborted' ]
on: Error 
do: [ :e | UIManager default handleError: e].
Smalltalk tools debuggerTool: currentDebugger.
"
Class {
	#name : #PhLErrorDialogPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'acceptButton',
		'cancelButton',
		'debugSession',
		'description'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #specs }
PhLErrorDialogPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #description;
		yourself
]

{ #category : #'opening api' }
PhLErrorDialogPresenter class >> openDebuggerOn: debugSession [
	GTGenericStackDebugger
		openOn: debugSession
		withFullView: true
		andNotification: ''
]

{ #category : #'opening api' }
PhLErrorDialogPresenter class >> openOn: debugSession withFullView: bool andNotification: notificationString [
	PharoLauncherApplication isDeployed
		ifTrue: [ (self on: debugSession) openDialogWithSpec ]
		ifFalse: [ self openDebuggerOn: debugSession ]
]

{ #category : #accessing }
PhLErrorDialogPresenter >> debugSession [ 
	^ debugSession
]

{ #category : #initialization }
PhLErrorDialogPresenter >> initializeDialogWindow: aDialogWindowPresenter [
	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter buttons
		detect: [ :button | button label = 'Ok' ]
		ifFound: [ :button | button label: 'Debug' ].
	aDialogWindowPresenter buttons
		detect: [ :button | button label = 'Cancel' ]
		ifFound: [ :button | button label: 'Ignore' ].
	aDialogWindowPresenter
		cancelAction: [ self debugSession terminate ];
		okAction: [ self class openDebuggerOn: self debugSession ]
]

{ #category : #initialization }
PhLErrorDialogPresenter >> initializePresenters [ 
	description := self newText
		beNotEditable;
		text: self debugSession name;
		yourself.
]

{ #category : #initialization }
PhLErrorDialogPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		title: 'An error occured!';
		initialExtent: 390 @ 167.
]

{ #category : #initialization }
PhLErrorDialogPresenter >> setModelBeforeInitialization: aDebugSession [
	debugSession := aDebugSession
]
