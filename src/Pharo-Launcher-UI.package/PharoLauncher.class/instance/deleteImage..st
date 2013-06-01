action-images
deleteImage: anImage
	(UIManager default confirm: 'Are you sure you want to delete ' , anImage name , '?')
		ifTrue: [ 
			imageGroup deleteImage: anImage.
			self updateImages ]