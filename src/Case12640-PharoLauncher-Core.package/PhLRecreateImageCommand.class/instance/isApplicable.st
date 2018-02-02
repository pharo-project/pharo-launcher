testing
isApplicable
	^ context hasAtLeastOneImageSelected and: 
		[  context selectedImages allSatisfy: [ :image | image originTemplate notNil ] ].