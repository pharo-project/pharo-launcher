Class {
	#name : #PhlLaunchConfigurationForm,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameLabeledInput',
		'commandLabeledInput'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

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
		subwidget: self newTextInput.
	commandLabeledInput := (self instantiate: LabelledContainer)
		label: 'Command';
		subwidget: self newTextInput.

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
