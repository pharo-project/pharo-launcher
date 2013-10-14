action
makeUniqueImageName: baseImageName among: existingImageNames
	| similarbaseImageNames existingUniquifiers nextUniquifier separator |
	separator := '-'.
	similarbaseImageNames := existingImageNames
		select: [ :imageName | imageName = baseImageName or: (imageName beginsWith: baseImageName) ].
	similarbaseImageNames ifEmpty: [ ^ baseImageName ].
	existingUniquifiers := similarbaseImageNames
		collect: [ :imageName | | suffix |
			suffix := imageName allButFirst: baseImageName size.
			(suffix beginsWith: separator)
				ifTrue: [ (suffix allButFirst: separator size) asInteger ]
				ifFalse: 0].
	nextUniquifier := existingUniquifiers max + 1.
	^ baseImageName , separator , (nextUniquifier printPaddedWith: $0 to: 2)