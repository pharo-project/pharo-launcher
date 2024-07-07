"
A simple presenter to allow to retry or cancel an action. You can provide an explanation text.
"
Class {
	#name : 'PhLRetryPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'retryBlock',
		'cancelBlock',
		'explanationText',
		'iconPresenter'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'example' }
PhLRetryPresenter class >> example [
	(self new
		explanation: 'Download error (probably a network error)';
		retryBlock: [ "nothing" ];
		cancelBlock: [ #() ]
	) openModal
]

{ #category : 'accessing' }
PhLRetryPresenter >> cancelBlock: aBlock [
	cancelBlock := aBlock
]

{ #category : 'layout' }
PhLRetryPresenter >> defaultLayout [ 
	^ SpBoxLayout newLeftToRight 
		spacing: 10;
		add: iconPresenter expand: false;
		add:  explanationText;
		yourself
]

{ #category : 'accessing' }
PhLRetryPresenter >> explanation: aString [ 
	explanationText text: aString
]

{ #category : 'initialization' }
PhLRetryPresenter >> initializeDialogWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Retry?';
		initialExtent: 400 @ 200;
		addButton: 'Retry' do: [ :presenter | presenter close. retryBlock value. ];
		addButton: 'Cancel' do: [ :presenter | presenter beCancel; close. cancelBlock value. ];
		centeredRelativeToTopWindow	
]

{ #category : 'initialization' }
PhLRetryPresenter >> initializePresenters [
	explanationText := self newText
		beNotEditable;
		yourself.
		
	iconPresenter := self newImage 
		image: (self iconNamed: #smallUpdate);
		yourself
]

{ #category : 'accessing' }
PhLRetryPresenter >> retryBlock: aBlock [
	retryBlock := aBlock
]
