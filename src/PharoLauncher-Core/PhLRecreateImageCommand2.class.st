"
Refresh the currently selected image.
It will first drop the current local image and fetch a fresh version of the template. The name of the local image will not be updated.
"
Class {
	#name : #PhLRecreateImageCommand2,
	#superclass : #PhLImageCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLRecreateImageCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #refreshIcon;
		shortcutKey: $R meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #'user interaction' }
PhLRecreateImageCommand2 >> askConfirmation [
	| confirmMessage |
	
	confirmMessage := 'Are you sure you want to recreate this image?' , Character cr asString, 
							'This will overwrite the existing image and you will lose changes.'.
	^ self imagesPresenter newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
]

{ #category : #executing }
PhLRecreateImageCommand2 >> execute [
	self askConfirmation
		ifTrue: [ self imagesPresenter selectedImages 
						do: [ :image |	self imagesPresenter imageRepository recreateImage: image ] ]
]

{ #category : #initialization }
PhLRecreateImageCommand2 >> initialize [
	super initialize.
	self
		name: 'Recreate';
		description: self class comment
]
