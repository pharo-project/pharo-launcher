"
Open Launch configuration editor for the selected image.
"
Class {
	#name : #PhLOpenLaunchConfigurationEditorCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLOpenLaunchConfigurationEditorCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #edit;
		yourself
]

{ #category : #executing }
PhLOpenLaunchConfigurationEditorCommand >> execute [

	^ (PhLLaunchConfigurationPresenter
		   newApplication: self imagesPresenter application
		   model: self imagesPresenter singleImage)
		  open;
		  yourself
]

{ #category : #initialization }
PhLOpenLaunchConfigurationEditorCommand >> initialize [
	super initialize.
	self 
		name: '';
		description: self class comment.
]
