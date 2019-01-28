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

	"First is the default configuration
	After adding two new configurations, last is third"
	editor configurationList clickItem: 3.

	self assert: (image launchConfigurations last == editor selectedConfiguration)
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickOnLaunchConfigurationListItemSetsFormName [
	
	| name |
	name := 'test'.
	image addLaunchConfiguration: (PhlLaunchConfiguration named: name).
	editor refreshList.
	
	editor configurationList clickItem: 2.

	self assert: editor form nameInput text equals: name
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
	self assert: (editor configurationList displayValueAt: 1) equals: '<no name>'.
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
	menu := editor configurationList rightClickItem: 1.

	self assert: (menu menuGroups first menuItems anySatisfy: [ :each | each title = 'Delete' ])
]
