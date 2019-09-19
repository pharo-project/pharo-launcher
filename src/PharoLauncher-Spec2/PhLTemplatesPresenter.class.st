"
Pharo Launcher templates window presenting the list of available templates.
Templates are used to create images.

To open me:
	self example
"
Class {
	#name : #PhLTemplatesPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'templateTable',
		'descriptionPanel',
		'categoryTable'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLTemplatesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #categoryTable;
		add: (SpBoxLayout newVertical 
			add: #templateTable;
			add: #descriptionPanel;
			yourself);
		yourself		
]

{ #category : #example }
PhLTemplatesPresenter class >> example [
	(self on: PhLTemplateGroupRepository default) openWithSpec
]

{ #category : #initialization }
PhLTemplatesPresenter >> initializePresenter [

	super initializePresenter.
	categoryTable transmitTo: templateTable transform: [ :group | group children ]
]

{ #category : #initialization }
PhLTemplatesPresenter >> initializeWidgets [ 
	categoryTable := self newList
		items: self model roots;
		yourself.
	templateTable := self newList.

	descriptionPanel := self instantiate: PhLImageDetailPresenter on: PhLNullImage new.
]

{ #category : #initialization }
PhLTemplatesPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Pharo Launcher - Image creation';
		initialExtent: 700 @ 500;
		"toolBar: (self rootCommandsGroup / 'Toolbar') asToolbarPresenter;"
		whenBuiltDo: [ :ann | ann model centered ].	
	"self rootCommandsGroup installShortcutsIn: aWindowPresenter"
]
