copying
withNewSelection: aSelection
	^ self copy
		setSelection: aSelection imageRepository: imageRepository templateRepository: templateRepository;
		yourself