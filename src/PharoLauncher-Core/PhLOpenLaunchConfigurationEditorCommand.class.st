"
Open Launch configuration editor for the selected image.
"
Class {
	#name : #PhLOpenLaunchConfigurationEditorCommand,
	#superclass : #PhLGeneralCommand,
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
			newApplication: self application
			model: nil)
		openWithSpec;
		yourself
]

{ #category : #initialization }
PhLOpenLaunchConfigurationEditorCommand >> initialize [
	super initialize.
	self 
		name: '';
		description: self class comment.
]
