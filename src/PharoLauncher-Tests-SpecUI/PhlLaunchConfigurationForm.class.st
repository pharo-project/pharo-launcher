Class {
	#name : #PhlLaunchConfigurationForm,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameLabeledInput',
		'commandLabeledInput'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #specs }
PhlLaunchConfigurationForm class >> defaultSpec [
	
	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #nameLabeledInput height: 50;
				newRow: #commandLabeledInput height: 50 ]
]

{ #category : #accessing }
PhlLaunchConfigurationForm >> commandInput [
	
	^ commandLabeledInput subwidget
]

{ #category : #initialization }
PhlLaunchConfigurationForm >> initialize [

	self model ifNil: [ self model: PhlLaunchConfiguration new ].
	super initialize.
]

{ #category : #initialization }
PhlLaunchConfigurationForm >> initializeWidgets [
	
	nameLabeledInput := (self instantiate: LabelledContainer)
		label: 'Name';
		subwidget: self newTextInput;
		whenTextChanged: [ :newText | self model name: newText ];
		autoAccept: true;
		yourself.

	commandLabeledInput := (self instantiate: LabelledContainer)
		label: 'Command';
		subwidget: self newTextInput;
		whenTextChanged: [ :newText | self model command: newText ];
		autoAccept: true;
		yourself.

	self refreshModel.
]

{ #category : #accessing }
PhlLaunchConfigurationForm >> nameInput [

	^ nameLabeledInput subwidget
]

{ #category : #initialization }
PhlLaunchConfigurationForm >> refreshModel [

	self nameInput text: self model name.
	self commandInput text: self model command.
]

{ #category : #initialization }
PhlLaunchConfigurationForm >> whenChangedDo: aBlock [

	self nameInput whenTextChanged: aBlock.
	self commandInput whenTextChanged: aBlock.
]
