"
Refresh the currently selected image.
It will first drop the current local image and fetch a fresh version of the template. The name of the local image will not be updated.
"
Class {
	#name : #PhLRecreateImageCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLRecreateImageCommand class >> icon [
	^ self iconNamed: #refreshIcon
]

{ #category : #accessing }
PhLRecreateImageCommand class >> title [
	^ 'Recreate'
]

{ #category : #private }
PhLRecreateImageCommand >> askConfirmation [
	| confirmMessage |
	
	confirmMessage := 'Are you sure you want to recreate this image?' , Character cr asString, 
							'This will overwrite the existing image and you will lose changes.'.
	^ self model newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
]

{ #category : #action }
PhLRecreateImageCommand >> execute [
	self askConfirmation
		ifTrue: [ self model selectedImages 
			do: [ :image | | template |
				template := image originTemplate. 
				self model imageRepository
					deleteImages: { image }; 
					extractTemplate: template to: image name ]
			]
	

]

{ #category : #testing }
PhLRecreateImageCommand >> isApplicable [
	^ self model hasAtLeastOneImageSelected and: 
		[ self model selectedImages allSatisfy: [ :image | image originTemplate notNil ] ].
]
