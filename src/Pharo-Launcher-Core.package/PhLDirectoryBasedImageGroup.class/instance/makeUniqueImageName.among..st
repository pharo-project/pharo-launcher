action
makeUniqueImageName: baseImageName among: existingImageNames
	|  similarbaseImageNames existingUniquifiers nextUniquifier |
	similarbaseImageNames := 
		existingImageNames select: 
		[ 	:imageName | 
			(imageName = baseImageName) or: (imageName beginsWith: baseImageName ) 
		].
	similarbaseImageNames ifEmpty: [  ^baseImageName ].
	existingUniquifiers := 
		similarbaseImageNames collect: 
		[  	:imageName |  
			( (imageName allButFirst: baseImageName size) asInteger 
				ifNil: [  0 ] 
			) abs.
		].
	nextUniquifier := existingUniquifiers max + 1.
	^ baseImageName , '-' , (nextUniquifier printPaddedWith: $0 to: 2).