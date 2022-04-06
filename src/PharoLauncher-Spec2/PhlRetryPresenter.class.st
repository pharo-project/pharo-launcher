"
A simple presenter to allow to retry or cancel an action. You can provide an explanation text.
"
Class {
	#name : #PhlRetryPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'retryBlock',
		'cancelBlock',
		'explanationText'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #layout }
PhlRetryPresenter class >> defaultLayout [ 
	^ SpBoxLayout newHorizontal
		"add: (self iconNamed: #smallUpdate) expand: false;"
		add:  #explanationText;
		yourself
]

{ #category : #example }
PhlRetryPresenter class >> example [
	(self new
		explanation: 'Download error (probably a network error)';
		retryBlock: [ "nothing" ];
		cancelBlock: [ #() ]
	) openModal
]

{ #category : #accessing }
PhlRetryPresenter >> cancelBlock: aBlock [
	cancelBlock := aBlock
]

{ #category : #accessing }
PhlRetryPresenter >> explanation: aString [ 
	explanationText label: aString
]

{ #category : #initialization }
PhlRetryPresenter >> initializeDialogWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Retry?';
		initialExtent: 400 @ 120;
		addButton: 'Retry' do: [ :presenter | presenter close. retryBlock value. ];
		addButton: 'Cancel' do: [ :presenter | presenter beCancel; close. cancelBlock value. ];
		centeredRelativeToTopWindow	
]

{ #category : #initialization }
PhlRetryPresenter >> initializePresenters [
	explanationText := self newLabel.
]

{ #category : #accessing }
PhlRetryPresenter >> retryBlock: aBlock [
	retryBlock := aBlock
]
