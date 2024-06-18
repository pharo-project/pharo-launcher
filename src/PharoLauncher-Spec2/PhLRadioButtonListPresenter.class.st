Class {
	#name : 'PhLRadioButtonListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'displayBlock',
		'selected',
		'items'
	],
	#category : 'PharoLauncher-Spec2-View-Dialogs',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Dialogs'
}

{ #category : 'layout' }
PhLRadioButtonListPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
]

{ #category : 'api' }
PhLRadioButtonListPresenter >> display: aBlock [

	displayBlock := aBlock
]

{ #category : 'initialization' }
PhLRadioButtonListPresenter >> initialize [

	super initialize.
	displayBlock := [ :anObject | anObject asString ]
]

{ #category : 'initialization' }
PhLRadioButtonListPresenter >> initializePresenters [
	
	self addStyle: 'choice_area'
]

{ #category : 'api' }
PhLRadioButtonListPresenter >> items: aCollection [
	| first radio associated | 

	items := aCollection.
	associated := OrderedCollection new.
	aCollection withIndexDo: [ :each :index |
		radio := self newRadioButton
			label: (displayBlock value: each);
			whenActivatedDo: [ selected := each ];
			yourself.
		self layout 
			add: radio expand: false.
		index = 1 
			ifTrue: [ first := radio ]
			ifFalse: [ associated add: radio ] ].
	first associatedRadioButtons: associated
]

{ #category : 'api - selection' }
PhLRadioButtonListPresenter >> selectFirst [

	self selectIndex: 1
]

{ #category : 'api - selection' }
PhLRadioButtonListPresenter >> selectIndex: index [

	(self layout children at: index) state: true.
	selected := items at: index	
]

{ #category : 'api - selection' }
PhLRadioButtonListPresenter >> selectItem: anObject [ 

	self selectIndex: (items indexOf: anObject)
]

{ #category : 'api - selection' }
PhLRadioButtonListPresenter >> selectedItem [

	^ selected
]
