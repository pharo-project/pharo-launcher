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
		'location',
		'vm',
		'templateUrl'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLImageDetailPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #imageLabel
			withConstraints: [ :constraints | constraints height: self labelHeight * 1.5 ];
		add:
			(SpBoxLayout newHorizontal
				add: 'description:' withConstraints: self labelConstraintsBlock;
				add: #description;
				yourself);
		add:
			(SpBoxLayout newHorizontal
				add: 'Origin template:' withConstraints: self labelConstraintsBlock;
				add: #template;
				yourself)
			height: self labelHeight;
		add:
			(SpBoxLayout newHorizontal
				add: '' withConstraints: self labelConstraintsBlock;
				add: #templateUrl;
				yourself)
			height: self labelHeight;
		add:
			(SpBoxLayout newHorizontal
				add: 'Location:' withConstraints: self labelConstraintsBlock;
				add: #location;
				yourself)
			height: self labelHeight;
		yourself
]

{ #category : #specs }
PhLImageDetailPresenter class >> labelConstraintsBlock [
	^ [ :constraints | 
	constraints
		height: self labelHeight;
		width: self labelWidth ]
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
PhLImageDetailPresenter >> initializePresenter [
	description
		whenTextIsAcceptedDo: [ :text | self image description: text ]
]

{ #category : #initialization }
PhLImageDetailPresenter >> initializeWidgets [
	imageLabel := self newLabel.
	description := self newText.
	template := self newLabel.
	templateUrl := self newLabel.
	location := self newLabel.
	vm := self newTextInput.
]

{ #category : #accessing }
PhLImageDetailPresenter >> location [
	^ location
]

{ #category : #initialization }
PhLImageDetailPresenter >> modelChanged [ 

	imageLabel label: self image name asText allBold, ' image, last edited ', self image lastModification asString.
	description text: self image description.
	template label: self image originTemplateName.
	templateUrl label: self image originTemplateUrl.
	location label: self image location.
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
