"
A simple presenter to allow to retry or cancel an action. You can provide an explanation text.
"
Class {
	#name : #PhlRetryPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'retryBlock',
		'cancelBlock',
		'explanationText',
		'iconPresenter'
	],
	#category : #'PharoLauncher-Spec2'
}

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

{ #category : #layout }
PhlRetryPresenter >> defaultLayout [ 
	^ SpBoxLayout newLeftToRight 
		spacing: 10;
		add: iconPresenter expand: false;
		add:  explanationText;
		yourself
]

{ #category : #accessing }
PhlRetryPresenter >> explanation: aString [ 
	explanationText text: aString
]

{ #category : #initialization }
PhlRetryPresenter >> initializeDialogWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Retry?';
		initialExtent: 400 @ 200;
		addButton: 'Retry' do: [ :presenter | presenter close. retryBlock value. ];
		addButton: 'Cancel' do: [ :presenter | presenter beCancel; close. cancelBlock value. ];
		centeredRelativeToTopWindow	
]

{ #category : #initialization }
PhlRetryPresenter >> initializePresenters [
	explanationText := self newText
		beNotEditable;
		yourself.
		
	iconPresenter := self newImage 
		image: (self iconNamed: #smallUpdate);
		yourself
]

{ #category : #accessing }
PhlRetryPresenter >> retryBlock: aBlock [
	retryBlock := aBlock
]
