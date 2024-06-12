"
Refresh the currently selected image.
It will first drop the current local image and fetch a fresh version of the template. The name of the local image will not be updated.
"
Class {
	#name : 'PhLRecreateImageCommand',
	#superclass : 'PhLImageCommand',
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLRecreateImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #refresh;
		shortcutKey: $R actionModifier;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : 'user interaction' }
PhLRecreateImageCommand >> askConfirmation [
	| confirmMessage |
	
	confirmMessage := 'Are you sure you want to recreate this image?' , Character cr asString, 
							'This will overwrite the existing image and you will lose your changes.'.
	
	^ self imagesPresenter newConfirmation
		parentWindow: self context window;
		message: confirmMessage;
		confirm
]

{ #category : 'executing' }
PhLRecreateImageCommand >> execute [

	self askConfirmation ifFalse: [ ^ self ].
	
	self context application showWaitCursorWhile: [ 
		self imagesPresenter selectedImages do: [ :image |	
			self imagesPresenter imageRepository recreateImage: image ] ]
]

{ #category : 'initialization' }
PhLRecreateImageCommand >> initialize [
	super initialize.
	self
		name: 'Recreate';
		description: self class comment
]
