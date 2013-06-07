image action
deleteImage
	| image |
	image := self selectedImage.
	(UIManager default confirm: 'Are you sure you want to delete ' , image name , '?')
		ifTrue: [ 
			imageGroup deleteImage: image.
			self updateImages ]