"
Open Launch configuration editor for the selected image.
"
Class {
	#name : 'PhLOpenLaunchConfigurationEditorCommand',
	#superclass : 'PhLImageCommand',
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLOpenLaunchConfigurationEditorCommand >> asSpecCommand [

	^ super asSpecCommand
		iconName: #edit;
		yourself
]

{ #category : 'executing' }
PhLOpenLaunchConfigurationEditorCommand >> execute [

	((PhLLaunchConfigurationPresenter
		   newApplication: self imagesPresenter application
		   model: self imagesPresenter singleImage)
		owner: self context window;
		asModalWindow)
			owner: self context window;
			withoutButtons;
			open
]

{ #category : 'initialization' }
PhLOpenLaunchConfigurationEditorCommand >> initialize [
	
	super initialize.
	self 
		name: 'Edit launch configurations';
		description: self class comment.
]
