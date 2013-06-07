image action
copyImage
	| image newName |
	image := self selectedImage.
	newName := UIManager default request: 'New name'.
	imageGroup copyImage: image to: newName.
	self updateImages