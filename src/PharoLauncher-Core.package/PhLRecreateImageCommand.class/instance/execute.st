action
execute
	self askConfirmation
		ifTrue: [ context selectedImages 
			do: [ :image | | template |
				template := self templateFor: image.
				context imageRepository
					deleteImages: { image }; 
					extractTemplate: template to: image name ]
			]
	
