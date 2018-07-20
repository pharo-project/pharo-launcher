testing
isApplicable
	^ self model hasAtLeastOneImageSelected and: 
		[ self model selectedImages allSatisfy: [ :image | image originTemplate notNil ] ].