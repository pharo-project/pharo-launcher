image action
deleteImage
	| image |
	image := self selectedImage.
	(UIManager default confirm: 'Are you sure you want to delete ' , image name , '?')
		ifFalse: [ ^ self ].
	imageGroup deleteImage: image.
	self updateImages