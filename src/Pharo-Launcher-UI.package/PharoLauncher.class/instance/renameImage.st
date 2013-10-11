image action
renameImage
	| image newName |
	image := self selectedImage.
	newName := UIManager default request: 'New name'.
	newName ifNil: [ ^self ].
	imageGroup renameImage: image to: newName.
	self updateImages