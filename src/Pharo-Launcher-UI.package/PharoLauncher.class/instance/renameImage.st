action
renameImage
	| image newName |
	image := self selectedImage.
	newName := UIManager default request: 'New name'.
	imageGroup renameImage: image to: newName.
	self updateImages