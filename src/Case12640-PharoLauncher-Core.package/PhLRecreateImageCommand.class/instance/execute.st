action
execute
	self askConfirmation
		ifTrue: [ context selectedImages 
			do: [ :image | | template |
				template := image originTemplate. 
				context imageRepository
					deleteImages: { image }; 
					extractTemplate: template to: image name ]
			]
	
