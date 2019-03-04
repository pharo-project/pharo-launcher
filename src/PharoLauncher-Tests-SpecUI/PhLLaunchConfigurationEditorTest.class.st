Class {
	#name : #PhLLaunchConfigurationEditorTest,
	#superclass : #TestCase,
	#instVars : [
		'image',
		'editor'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> setUp [

	super setUp.
	image := PhLImage location: 'fruta' asFileReference.
	editor := PhlLaunchConfigurationEditor on: image.
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testAddButtonHasLabel [

	self assert: editor addButton label notEmpty
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickAddButtonCreatesNewLaunchConfiguration [

	| old |
	old := image launchConfigurations size.
	editor addButton click.

	self assert: image launchConfigurations size equals: old + 1
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickAddButtonSetsNewConfigurationAsSelectedConfiguration [

	| old |
	old := image launchConfigurations.
	editor addButton click.

	self assert: (old includes: editor selectedConfiguration)
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickOnLaunchConfigurationListItemSelectsConfiguration [
	
	2 timesRepeat: [ editor addButton click ].

	"First is the default configuration.
	Second is the default without settings configuration.
	After adding two new configurations, last is fourth"
	editor configurationList clickItem: 4.

	self assert: (image launchConfigurations last == editor selectedConfiguration)
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickOnLaunchConfigurationListItemSetsFormName [
	
	| name |
	name := 'test'.
	image addLaunchConfiguration: (PhlLaunchConfiguration named: name).
	editor refreshList.
	
	editor configurationList clickItem: 3.

	self assert: editor form nameInput text equals: name
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickOnRemoveMenuItemRemovesConfiguration [
	
	| menu configuration index menuItem |
	configuration := image launchConfigurations last.
	index := editor configurationList indexOfItem: configuration.
	
	menu := editor configurationList rightClickAtIndex: index.
	menuItem := menu items detect: [ :each | each name = 'Delete' ].
	
	menuItem click.
	self deny: (image launchConfigurations includes: configuration)
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testEditConfigurationNameUpdatesListItem [
	
	| newName |
	newName := 'some name'.
	editor addButton click.
	editor configurationList clickItem: 2.
	editor form nameInput text: newName.
	
	self assert: (editor configurationList displayValueAt: 2) equals: newName
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testListItemWithEmptyNameHasFiller [
	
	editor addButton click.
	self assert: (editor configurationList displayValueAt: 3) equals: PhlLaunchConfiguration emptyDisplayName.
	self assert: (image launchConfigurations last == editor selectedConfiguration)
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testOpenLaunchConfigurationEditorDoesNotFail [

	"Smoke test"
	(PhlLaunchConfigurationEditor on: image) openWithSpec close
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testRightClickOnLaunchConfigurationHasMenuItemRemove [
	
	| menu |
	menu := editor configurationList rightClickAtIndex: 1.
	self assert: (menu items anySatisfy: [ :each | each name = 'Delete' ])
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testRightClickOutsideItemsHasNoMenuItem [

	self assert: (editor configurationList rightClickAtIndex: 5) isNil
]
