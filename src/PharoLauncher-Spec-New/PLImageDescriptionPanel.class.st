Class {
	#name : #PLImageDescriptionPanel,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameLabel',
		'templateLabel',
		'locationLabel',
		'modifiedLabel',
		'architectureLabel',
		'descriptionLabel'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLImageDescriptionPanel class >> defaultSpec [
	
	^ SpecGridLayout new
		beColumnNotHomogeneous;
		add: 'Name' 					at: 1@1; add: #nameLabel 				at: 2@1;
		add: 'Template' 			at: 1@2; add: #templateLabel 			at: 2@2;
		add: 'Location' 			at: 1@3; add: #locationLabel 			at: 2@3;
		add: 'Achitecture'			at: 1@4; add: #architectureLabel 		at: 2@4;
		add: 'Modified' 			at: 1@5;	add: #modifiedLabel 			at: 2@5;
		add: 'Description' 		at: 1@6;	
		add: #descriptionLabel 	at: 1@7 span: 2@2;
		yourself
]

{ #category : #accessing }
PLImageDescriptionPanel >> architectureLabel [
	^ architectureLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> architectureLabel: anObject [
	architectureLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> descriptionLabel [
	^ descriptionLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> descriptionLabel: anObject [
	descriptionLabel := anObject
]

{ #category : #initialization }
PLImageDescriptionPanel >> initializePresenter [

	self modelChanged
]

{ #category : #initialization }
PLImageDescriptionPanel >> initializeWidgets [
	
	nameLabel := self newLabel.
	templateLabel := self newLabel.	
	locationLabel:= self newLabel.
	modifiedLabel := self newLabel.
	architectureLabel := self newLabel.
	descriptionLabel := self newLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> locationLabel [
	^ locationLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> locationLabel: anObject [
	locationLabel := anObject
]

{ #category : #initialization }
PLImageDescriptionPanel >> modelChanged [
	
	nameLabel label: self model name.
	templateLabel label: self model originTemplateName.
	locationLabel label: (self model location ifNotNil: #fullName).
	modifiedLabel label: (self model lastModification 
		ifNotNil: #asLocalStringYMDHM
		ifNil: [ '' ]).
	architectureLabel label: self model arch.
	descriptionLabel label: self model description
]

{ #category : #accessing }
PLImageDescriptionPanel >> modifiedLabel [
	^ modifiedLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> modifiedLabel: anObject [
	modifiedLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> nameLabel [
	
	^ nameLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> nameLabel: anObject [
	nameLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> templateLabel [
	^ templateLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> templateLabel: anObject [
	templateLabel := anObject
]
