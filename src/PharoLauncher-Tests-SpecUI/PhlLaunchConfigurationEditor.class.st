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

{ #category : #specs }
PhlLaunchConfigurationEditor class >> defaultSpec [
	
	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #list height: 130;
				newRow: #addButton height: 30;
				newRow: #form ]
]

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

{ #category : #menu }
PhlLaunchConfigurationEditor >> buildMenu [
	
	| menu |
	menu := MenuPresenter new.
	menu addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Delete';
				iconName: #remove;
				action: [ self removeSelectedItem ] ] ].
	^ menu
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
	list displayBlock: [ :configuration | configuration displayName ].
	list
		whenSelectionChangedDo: [ :selection | 
			self flag: #bug.
			"Uncomment to show bug"
			"selection ifNotNil: ["
			self refreshForm	" ]" ].
	list menu: [ self buildMenu ].
	addButton := self newButton.
	addButton label: 'Add configuration'.
	addButton action: [ self addNewConfiguration ].
	form := self instantiate: PhlLaunchConfigurationFormPresenter.
	form whenChangedDo: [ self refreshList ].
	self refreshList
]

{ #category : #initialization }
PhlLaunchConfigurationEditor >> refreshForm [

	self selectedConfiguration ifNil: [ ^ self ].
	form
		model: self selectedConfiguration;
		refreshPresenterFromModel
]

{ #category : #initialization }
PhlLaunchConfigurationEditor >> refreshList [
	
	list items: self model launchConfigurations.
]

{ #category : #menu }
PhlLaunchConfigurationEditor >> removeSelectedItem [
	
	^ self model removeConfiguration: self selectedConfiguration
]

{ #category : #accessing }
PhlLaunchConfigurationEditor >> selectedConfiguration [
	^ list selection selectedItem
]

{ #category : #accessing }
PhlLaunchConfigurationEditor >> selectedConfiguration: aConfiguration [
	list selectItem: aConfiguration
]
