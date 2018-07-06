instance creation
forImage: aPharoImagePathOrFileReference
	^ self new 
		imageFile: aPharoImagePathOrFileReference asFileReference;
		yourself
		
		