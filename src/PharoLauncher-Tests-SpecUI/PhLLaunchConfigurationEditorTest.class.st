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
PhLLaunchConfigurationEditorTest >> bugSpec [
	
	| name |
	name := 'test'.
	image addLaunchConfiguration: (PhlLaunchConfiguration named: name).
	editor refreshList.
	
	editor configurationList clickItem: 2.

	self assert: editor form nameInput text equals: name
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> setUp [

	super setUp.
	image := PhLImage location: 'fruta' asFileReference.
	editor := PhlLaunchConfigurationEditor on: image.
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
