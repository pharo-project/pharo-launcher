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
