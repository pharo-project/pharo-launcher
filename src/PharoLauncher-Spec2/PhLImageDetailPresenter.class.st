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
		'shouldRunInitializationScript',
		'updating'
	],
	#category : #'PharoLauncher-Spec2'
}

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
	
	description whenTextChangedDo: [ :text | self updateImageDescription: text ].
	shouldRunInitializationScript whenChangedDo: [ :state | self updateImageRunScript: state ].
]

{ #category : #layout }
PhLImageDetailPresenter >> defaultLayout [ 
	
	^ SpBoxLayout newTopToBottom 
		borderWidth: 5;
		add: imageLabel expand: false fill: false padding: 10;
		add: self descriptionLayout;
		yourself
]

{ #category : #accessing }
PhLImageDetailPresenter >> description [
	^ description
]

{ #category : #layout }
PhLImageDetailPresenter >> descriptionLayout [ 
	^ SpGridLayout build: [ :builder |
		builder
		beRowNotHomogeneous;
		beColumnNotHomogeneous;
		borderWidth: 0;
		"column: 1 withConstraints: [ :c | c beNotExpand ];"
		column: 2 withConstraints: [ :c | c beExpand ];
			add: 'Description'; add: description; nextRow;
			add: 'Origin template'; add: template; nextRow;
			add: ''; add: templateUrl; nextRow;
			add: 'Initialization script'; add: (SpBoxLayout newLeftToRight
																add: initializationScript expand: false; 
																add: shouldRunInitializationScript expand: false;
																yourself); nextRow;
			add: 'Location'; add: location ]
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
PhLImageDetailPresenter >> initialize [

	updating := false.
	super initialize.
]

{ #category : #initialization }
PhLImageDetailPresenter >> initializePresenters [

	imageLabel := self newLabel.
	imageLabel addStyle: 'lightBlue'.
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
	
	updating := true.
	
	image := self image ifNil: [ PhLNullImage new ].
	
	imageLabel label: image name, ' image, last edited ', image lastModification asString.
	description text: image description.
	template label: (image originTemplateName ifEmpty: [ '(noname)' ]).
	templateUrl label: image originTemplateUrl.
	image initializationScript 
		ifNil: [ 
			initializationScript label: '<none>'.
			shouldRunInitializationScript disable. ] 
		ifNotNil: [ :script | 
			initializationScript label: script basename.
			shouldRunInitializationScript 
				enable;
				state: image shouldRunInitializationScript. ].
	location label: image location.
	vm text: 'N/A'. "self image vm."
	
	updating := false
]

{ #category : #accessing }
PhLImageDetailPresenter >> template [
	^ template
]

{ #category : #accessing }
PhLImageDetailPresenter >> templateUrl [
	^ templateUrl
]

{ #category : #initialization }
PhLImageDetailPresenter >> updateImageDescription: text [
	
	updating ifTrue: [ ^ self ].

	PhLImageDescriptionUpdater 
		image: self image 
		description: text
]

{ #category : #initialization }
PhLImageDetailPresenter >> updateImageRunScript: state [

	updating ifTrue: [ ^ self ].
	
	self image shouldRunInitializationScript: state
]

{ #category : #accessing }
PhLImageDetailPresenter >> vm [
	^ vm
]
