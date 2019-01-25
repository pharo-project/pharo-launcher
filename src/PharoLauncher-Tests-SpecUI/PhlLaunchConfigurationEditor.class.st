Class {
	#name : #PhlLaunchConfigurationEditor,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'list',
		'addButton',
		'form'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #accessing }
PhlLaunchConfigurationEditor >> addButton [
	
	^ addButton
]

{ #category : #actions }
PhlLaunchConfigurationEditor >> addNewConfiguration [
	
	| newConfiguration |
	newConfiguration := self model addNewLaunchConfiguration.
	self refreshList.
	self selectedConfiguration: newConfiguration.
]

{ #category : #accessing }
PhlLaunchConfigurationEditor >> configurationList [
	
	^ list
]

{ #category : #accessing }
PhlLaunchConfigurationEditor >> form [
	
	^ form
]

{ #category : #initialization }
PhlLaunchConfigurationEditor >> initializeWidgets [
	list := self newList.
	list displayBlock: #name.
	list whenSelectionChanged: [ :selection |
		self flag: #bug.
		"Uncomment to show bug"
		"selection ifNotNil: [" self refreshForm" ]" ].
	
	addButton := self newButton.
	addButton action: [ self addNewConfiguration ].
	
	form := self instantiate: PhlLaunchConfigurationForm.
	
	self refreshList.
]

{ #category : #initialization }
PhlLaunchConfigurationEditor >> refreshForm [

	self selectedConfiguration ifNil: [ ^ self ].
	form
		model: self selectedConfiguration;
		refreshModel
]

{ #category : #initialization }
PhlLaunchConfigurationEditor >> refreshList [
	
	list items: self model launchConfigurations.
]

{ #category : #accessing }
PhlLaunchConfigurationEditor >> selectedConfiguration [
	
	^ list selectedItem
]

{ #category : #accessing }
PhlLaunchConfigurationEditor >> selectedConfiguration: aConfiguration [
	
	list setSelectedItem: aConfiguration
]
