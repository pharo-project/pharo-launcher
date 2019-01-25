Class {
	#name : #PhLLaunchConfigurationEditorTest,
	#superclass : #TestCase,
	#instVars : [
		'image'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> setUp [

	super setUp.
	image := PhLImage location: 'fruta' asFileReference.
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickAddButtonCreatesNewLaunchConfiguration [

	| old editor |
	old := image launchConfigurations size.
	editor := PhlLaunchConfigurationEditor on: image.
	editor addButton click.

	self assert: image launchConfigurations size equals: old + 1
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickAddButtonSetsNewConfigurationAsSelectedConfiguration [

	| old editor |
	old := image launchConfigurations.
	editor := PhlLaunchConfigurationEditor on: image.
	editor addButton click.

	self assert: (old includes: editor selectedConfiguration)
]

{ #category : #tests }
PhLLaunchConfigurationEditorTest >> testClickOnLaunchConfigurationListItemSelectsConfiguration [

	| editor |
	editor := PhlLaunchConfigurationEditor on: image.
	
	2 timesRepeat: [ editor addButton click ].

	"First is the default configuration
	After adding two new configurations, last is third"
	editor configurationList clickItem: 3.

	self assert: (image launchConfigurations last == editor selectedConfiguration)
]
