action
makeUniqueImageName: baseImageName among: existingImageNames
	"Provide a reasonable default image name using the next incremental count for images with similar basenames"
	"See #testMakeUniqueImageName for samples"
	
	| similarbaseImageNames existingUniquifiers nextUniquifier separator |
	separator := '-'.
	similarbaseImageNames := existingImageNames select: [ :imageName | imageName beginsWith: baseImageName ].
	existingUniquifiers := similarbaseImageNames
		collect: [ :imageName | | suffix |
			suffix := imageName allButFirst: baseImageName size.
			(suffix beginsWith: separator)
				ifTrue: [ (suffix allButFirst: separator size) initialIntegerOrNil ]
				ifFalse: 0]
		thenSelect: #notNil.
	existingUniquifiers ifEmpty: [ ^ baseImageName ].
	nextUniquifier := existingUniquifiers max + 1.
	^ baseImageName , separator , (nextUniquifier printPaddedWith: $0 to: 2)