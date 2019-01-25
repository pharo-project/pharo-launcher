Class {
	#name : #PhlLaunchConfigurationEditor,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'list',
		'addButton'
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

{ #category : #initialization }
PhlLaunchConfigurationEditor >> initializeWidgets [
	list := self newList.
	list displayBlock: #name.
	
	addButton := self newButton.
	addButton action: [ self addNewConfiguration ].
	
	self refreshList.
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
