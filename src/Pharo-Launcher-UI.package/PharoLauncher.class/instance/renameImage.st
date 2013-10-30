image action
renameImage
	| image newName |
	self ensureSingleImageSelectedOr: [ ^self ].
	image := self selectedImage.
	newName := UIManager default request: 'New name' initialAnswer: image name.
	newName ifNil: [ ^self ].
	(self hasAlreadyImageWithName: newName) ifTrue: [ ^UIManager default inform: 'There is already an image with this name' ].	 
	imageGroup renameImage: image to: newName.
	self updateImages