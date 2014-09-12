printing
summaryInfoForImage: anImage 
	^ String
		streamContents: [ :output | 
			output nextPutAll: 'Last modified: '.
			anImage file modificationTime printOn: output.
			output
				cr;
				cr;
				nextPutAll: (self descriptionForImage: anImage) ]