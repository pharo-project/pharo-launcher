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
				newRow: #nameLabeledInput height: self labelledPresenterHeight;
				newRow: #commandLabeledInput height: self labelledPresenterHeight;
				addSpacer ]
]

{ #category : #accessing }
PhlLaunchConfigurationForm >> commandInput [
	
	^ commandLabeledInput input
]

{ #category : #initialization }
PhlLaunchConfigurationForm >> initialize [

	self model ifNil: [ self model: PhlLaunchConfiguration new ].
	super initialize.
]

{ #category : #initialization }
PhlLaunchConfigurationForm >> initializeWidgets [
	
	nameLabeledInput := (self instantiate: LabelledPresenter)
		label: 'Name';
		input: self newTextInput;
		yourself.
	nameLabeledInput input
		whenTextChanged: [ :newText | self model name: newText ];
		autoAccept: true.

	commandLabeledInput := (self instantiate: LabelledPresenter)
		label: 'Command';
		input: self newTextInput;
		yourself.
	commandLabeledInput input
		whenTextChanged: [ :newText | self model command: newText ];
		autoAccept: true.

	self refreshModel.
]

{ #category : #accessing }
PhlLaunchConfigurationForm >> nameInput [

	^ nameLabeledInput input
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
