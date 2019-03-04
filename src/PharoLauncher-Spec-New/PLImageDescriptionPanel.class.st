Class {
	#name : #PLImageDescriptionPanel,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameLabel',
		'nameLabelLabel',
		'templateLabelLabel',
		'templateLabel',
		'locationLabelLabel',
		'locationLabel',
		'modifiedLabelLabel',
		'modifiedLabel',
		'architectureLabelLabel',
		'architectureLabel',
		'descriptionLabelLabel',
		'descriptionLabel'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLImageDescriptionPanel class >> defaultSpec [
	
	^ SpecGridLayout new
		add: #nameLabelLabel at: 1@1;	
		add: #nameLabel at: 2@1;
		add: #templateLabelLabel at: 1@2;	
		add: #templateLabel at: 2@2;
		add: #locationLabelLabel at: 1@3;	
		add: #locationLabel at: 2@3;
		add: #architectureLabelLabel at: 1@4;	
		add: #architectureLabel at: 2@4;
		add: #modifiedLabelLabel at: 1@5;	
		add: #modifiedLabel at: 2@5;
		add: #descriptionLabelLabel at: 1@6;	
		add: #descriptionLabel at: 1@7 span: 2@2;
		beColumnNotHomogeneous;
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
PLImageDescriptionPanel >> architectureLabelLabel [
	^ architectureLabelLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> architectureLabelLabel: anObject [
	architectureLabelLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> descriptionLabel [
	^ descriptionLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> descriptionLabel: anObject [
	descriptionLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> descriptionLabelLabel [
	^ descriptionLabelLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> descriptionLabelLabel: anObject [
	descriptionLabelLabel := anObject
]

{ #category : #initialization }
PLImageDescriptionPanel >> initializePresenter [
	self modelChanged
]

{ #category : #initialization }
PLImageDescriptionPanel >> initializeWidgets [
	
	nameLabelLabel := self newLabel
		label: 'Name:';
		yourself.	
	nameLabel := self newLabel.
		
	templateLabelLabel := self newLabel
		label: 'Template:';
		yourself.	
	templateLabel := self newLabel.	

	locationLabelLabel := self newLabel
		label: 'Location:';
		yourself.		
	locationLabel:= self newLabel.
	
	modifiedLabelLabel := self newLabel
		label: 'Modified:';
		yourself.	
	modifiedLabel := self newLabel.
	
	architectureLabelLabel := self newLabel
		label: 'Architecture:';
		yourself.	
	architectureLabel := self newLabel.
	
	descriptionLabelLabel := self newLabel
		label: 'Description:';
		yourself.	
	descriptionLabel := self newLabel.
]

{ #category : #accessing }
PLImageDescriptionPanel >> locationLabel [
	^ locationLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> locationLabel: anObject [
	locationLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> locationLabelLabel [
	^ locationLabelLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> locationLabelLabel: anObject [
	locationLabelLabel := anObject
]

{ #category : #initialization }
PLImageDescriptionPanel >> modelChanged [
	
	nameLabel label: self model name.
	templateLabel label: self model originTemplateName.
	locationLabel label: (self model location ifNotNil: #fullName).
	modifiedLabel label: self model lastModification asString.
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
PLImageDescriptionPanel >> modifiedLabelLabel [
	^ modifiedLabelLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> modifiedLabelLabel: anObject [
	modifiedLabelLabel := anObject
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
PLImageDescriptionPanel >> nameLabelLabel [
	
	^ nameLabelLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> nameLabelLabel: anObject [
	nameLabelLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> templateLabel [
	^ templateLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> templateLabel: anObject [
	templateLabel := anObject
]

{ #category : #accessing }
PLImageDescriptionPanel >> templateLabelLabel [
	^ templateLabelLabel
]

{ #category : #accessing }
PLImageDescriptionPanel >> templateLabelLabel: anObject [
	templateLabelLabel := anObject
]
