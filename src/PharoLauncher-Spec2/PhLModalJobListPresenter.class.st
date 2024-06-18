Class {
	#name : 'PhLModalJobListPresenter',
	#superclass : 'SpJobListPresenter',
	#instVars : [
		'title'
	],
	#category : 'PharoLauncher-Spec2-View-Dialogs',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Dialogs'
}

{ #category : 'accessing' }
PhLModalJobListPresenter class >> defaultTitle [

	^ 'Process'
]

{ #category : 'initialization' }
PhLModalJobListPresenter >> initializeWindow: aWindowPresenter [ 

	aWindowPresenter
		title: self title;
		initialExtent: 500@(self jobPresenterHeight);
		beNotResizable;
		centered
]

{ #category : 'initialization' }
PhLModalJobListPresenter >> title [
		
	^ title ifNil: [ self class defaultTitle ]
]

{ #category : 'initialization' }
PhLModalJobListPresenter >> title: aTitle [

	title := aTitle
]
