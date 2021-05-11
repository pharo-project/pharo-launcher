"
Presenter of a Pharo image detail : description, template, VM, etc.

I'm part of the main Pharo Launcher window.

To open me:
(self on: PhLImage example) openWithSpec
"
Class {
	#name : #PhLImageDetailPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'description',
		'imageLabel',
		'template',
		'initializationScript',
		'location',
		'vm',
		'templateUrl',
		'shouldRunInitializationScript'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLImageDetailPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		add: #imageLabel expand: false;
		add: (SpGridLayout new
			beRowNotHomogeneous;
			beColumnNotHomogeneous;
			column: 1 withConstraints: [ :c | c beNotExpand; vAlignStart ];
			column: 2 withConstraints: [ :c | c beExpand ];
			add: 'Description' 				at: 1@1; add: #description 				at: 2@1;
			add: 'Origin template'		 	at: 1@2; add: #template 					at: 2@2;
															   add: #templateUrl 				at: 2@3;
			add: 'Initialization script' 	at: 1@4; add: (SpBoxLayout newLeftToRight
																	add: #initializationScript expand: false; 
																	add: #shouldRunInitializationScript expand: false;
																	yourself) at: 2@4;
			add: 'Location' 					at: 1@5; add: #location 					at: 2@5;
			yourself);	
		yourself
]

{ #category : #specs }
PhLImageDetailPresenter class >> labelConstraintsBlock [
	^ [ :constraints | 
	constraints
		height: self labelHeight;
		width: self labelWidth ]
]

{ #category : #'labelled-presenters' }
PhLImageDetailPresenter class >> labelWidth [
	^ 110
]

{ #category : #initialization }
PhLImageDetailPresenter >> connectPresenters [
	description
		whenTextChangedDo: [ :text | PhLImageDescriptionUpdater image: self image description: text ].
	shouldRunInitializationScript 
		whenChangedDo: [ :state | self image shouldRunInitializationScript: state ].
]

{ #category : #accessing }
PhLImageDetailPresenter >> description [
	^ description
]

{ #category : #accessing }
PhLImageDetailPresenter >> image [ 
	^ self model
]

{ #category : #accessing }
PhLImageDetailPresenter >> imageLabel [
	^ imageLabel
]

{ #category : #initialization }
PhLImageDetailPresenter >> initializePresenters [
	imageLabel := self newLabel.
	description := self newText.
	template := self newLabel.
	templateUrl := self newLabel.
	initializationScript := self newLabel.
	shouldRunInitializationScript := self newCheckBox
		help: 'Run the initialization script at next launch?';
		disable.
	location := self newLabel.
	vm := self newTextInput.
]

{ #category : #accessing }
PhLImageDetailPresenter >> location [
	^ location
]

{ #category : #updating }
PhLImageDetailPresenter >> modelChanged [ 
	| image |
	image := self image ifNil: [ PhLNullImage new ].
	
	imageLabel label: image name asText allBold, ' image, last edited ', image lastModification asString.
	description text: image description.
	template label: image originTemplateName.
	templateUrl label: image originTemplateUrl.
	image initializationScript 
		ifNil: [ initializationScript label: '<none>'.
			shouldRunInitializationScript disable. ] 
		ifNotNil: [:script | 
			initializationScript label: script basename.
			shouldRunInitializationScript 
				enable;
				state: image shouldRunInitializationScript. ].
	location label: image location.
	vm text: 'N/A'"self image vm".
]

{ #category : #accessing }
PhLImageDetailPresenter >> template [
	^ template
]

{ #category : #accessing }
PhLImageDetailPresenter >> templateUrl [
	^ templateUrl
]

{ #category : #accessing }
PhLImageDetailPresenter >> vm [
	^ vm
]
