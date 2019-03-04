Class {
	#name : #PhlLaunchConfigurationFormPresenter,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameLabeledInput',
		'commandLabeledInput'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #specs }
PhlLaunchConfigurationFormPresenter class >> defaultSpec [
	
	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #nameLabeledInput height: self labelledPresenterHeight;
				newRow: #commandLabeledInput height: self labelledPresenterHeight;
				addSpacer ]
]

{ #category : #accessing }
PhlLaunchConfigurationFormPresenter >> commandInput [
	
	^ commandLabeledInput input
]

{ #category : #initialization }
PhlLaunchConfigurationFormPresenter >> initialize [

	self model ifNil: [ self model: PhlLaunchConfiguration new ].
	super initialize.
]

{ #category : #initialization }
PhlLaunchConfigurationFormPresenter >> initializeWidgets [
	nameLabeledInput := (self instantiate: LabelledPresenter)
		label: 'Name';
		input: self newTextInput;
		yourself.
	nameLabeledInput input
		whenTextChangedDo: [ :newText | self model name: newText ];
		autoAccept: true.
	commandLabeledInput := (self instantiate: LabelledPresenter)
		label: 'Command';
		input: self newTextInput;
		yourself.
	commandLabeledInput input
		whenTextChangedDo: [ :newText | self model command: newText ];
		autoAccept: true.
	self refreshPresenterFromModel
]

{ #category : #accessing }
PhlLaunchConfigurationFormPresenter >> nameInput [

	^ nameLabeledInput input
]

{ #category : #initialization }
PhlLaunchConfigurationFormPresenter >> refreshPresenterFromModel [

	self nameInput text: self model name.
	self commandInput text: self model command.
]

{ #category : #accessing }
PhlLaunchConfigurationFormPresenter >> setModel: aModel [

	self model: aModel.
	self refreshPresenterFromModel.
]

{ #category : #initialization }
PhlLaunchConfigurationFormPresenter >> whenChangedDo: aBlock [
	self nameInput whenTextChangedDo: aBlock.
	self commandInput whenTextChangedDo: aBlock
]
