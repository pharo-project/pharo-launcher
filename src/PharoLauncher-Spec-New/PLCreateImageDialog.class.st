Class {
	#name : #PLCreateImageDialog,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameInputField',
		'templateList',
		'lastSuggestedName'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLCreateImageDialog class >> defaultSpec [

	^ SpecBoxLayout newVertical
		borderWidth: 10;
		spacing: 10;
		add: 'Select image template' expand: false fill: false padding: 0;
		add: #templateList expand: true fill: true padding: 0;
		add: (SpecBoxLayout newHorizontal
				borderWidth: 0;
				"rowSpacing: 0;"
				add: 'Image name' expand: false fill: false padding: 10;
				add: #nameInputField" at: 2 @ 1";
				yourself)
			expand: false 
			fill: false 
			padding: 0;
		yourself
]

{ #category : #private }
PLCreateImageDialog >> allImageNames [
	
	^ self application imageRepository imageNames
]

{ #category : #actions }
PLCreateImageDialog >> doCreateNewImageThen: aBlock [
	| context |

	self validate ifNotEmpty: [ :errors |
		errors do: [ :each | SpecNotification dispatchInfoTo: self window message: each ].
		^ self ].
	
	self flag: #TODO. "We need a better error managing. 
	And we need a better command patter too. 
	Bah, we need a better everything."
	context := PharoLauncherModel
		selection: { templateList selectedImage }
		imageRepository: PhLDirectoryBasedImageRepository default
		templateRepository: nil.
	[ (PhLCreateImageFromTemplateCommand on: context)
		newImageName: nameInputField text trimmed;
		execute ]
	on: PhLError 
	do: [ :e | 
		SpecNotification dispatchErrorTo: self application message: e messageText.
		^ self ].
	
	aBlock value	
]

{ #category : #initialization }
PLCreateImageDialog >> initialize [

	super initialize.
	lastSuggestedName := ''
]

{ #category : #initialization }
PLCreateImageDialog >> initializeDialogWindow: aDialogWindowPresenter [
	
	aDialogWindowPresenter
		addButton: 'Cancel' do: #close;
		addButton: 'Create' do: [ :presenter | 
			self doCreateNewImageThen: [ 
				presenter beOk; close ] ]
]

{ #category : #initialization }
PLCreateImageDialog >> initializeWidgets [

	templateList := self instantiate: PLTemplateList on: self model.
	(nameInputField := self newTextInput)
		autoAccept: true.
	
	templateList
		transmitTo: nameInputField
		transform: [ :aTemplate | self nameSuggestionFor: aTemplate ]
]

{ #category : #initialization }
PLCreateImageDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Create new image';
		initialExtent: 800@500;
		centered
]

{ #category : #private }
PLCreateImageDialog >> nameExists: aString [

	^ self allImageNames includes: aString trimmed
]

{ #category : #private }
PLCreateImageDialog >> nameSuggestionFor: aTemplate [
	| templatePossibleName allImageNames count |
	
	lastSuggestedName = nameInputField text ifFalse: [ ^ nameInputField text ].
	aTemplate ifNil: [ ^ '' ].
	
	"remove what is in parenthesis"
	templatePossibleName := (aTemplate name copyUpTo: $() trimmed.
	count := 0.
	allImageNames := self allImageNames.
		
	[ allImageNames includes: templatePossibleName ] 
	whileTrue: [ 
		count := count + 1.
		templatePossibleName := String streamContents: [ :stream |
			stream 
				<< templatePossibleName 
				<< ' (' << count asString << ')' ] ].
	
	lastSuggestedName := templatePossibleName.
	
	^ templatePossibleName
]

{ #category : #actions }
PLCreateImageDialog >> validate [
	"this should answer a list of problems but for now I stay with you one at a time"

	templateList selectedImage ifNil: [
		^ #('You need to select an image first') ].
	nameInputField text ifEmpty: [ 
		^ #('You need to add a name to your image') ].
	(self nameExists: nameInputField text) ifTrue: [
		^ #('This image name already exists, please choose another') ].
	
	^ #()
]
