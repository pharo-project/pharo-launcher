"
Refresh the currently selected image.
It will first drop the current local image and fetch a fresh version of the template. The name of the local image will not be updated.
"
Class {
	#name : #PhLRecreateImageCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLRecreateImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #refreshIcon;
		shortcutKey: $R meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #'user interaction' }
PhLRecreateImageCommand >> askConfirmation [
	| confirmMessage |
	
	confirmMessage := 'Are you sure you want to recreate this image?' , Character cr asString, 
							'This will overwrite the existing image and you will lose changes.'.
	^ self imagesPresenter newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
]

{ #category : #executing }
PhLRecreateImageCommand >> execute [
	self askConfirmation
		ifTrue: [ self imagesPresenter selectedImages 
						do: [ :image |	self imagesPresenter imageRepository recreateImage: image ] ]
]

{ #category : #initialization }
PhLRecreateImageCommand >> initialize [
	super initialize.
	self
		name: 'Recreate';
		description: self class comment
]
