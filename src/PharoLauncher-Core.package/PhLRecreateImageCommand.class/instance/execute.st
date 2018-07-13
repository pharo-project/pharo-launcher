action
execute
	self askConfirmation
		ifTrue: [ self model selectedImages 
			do: [ :image | | template |
				template := image originTemplate. 
				self model imageRepository
					deleteImages: { image }; 
					extractTemplate: template to: image name ]
			]
	
