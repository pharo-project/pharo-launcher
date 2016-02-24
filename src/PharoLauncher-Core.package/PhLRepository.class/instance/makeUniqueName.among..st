action
makeUniqueName: baseName among: existingNames
	"Provide a reasonable default name using the next incremental count for items with similar basenames"

	"See #testMakeUniqueImageName for samples"

	| similarbaseImageNames existingUniquifiers nextUniquifier separator |
	separator := '-'.
	similarbaseImageNames := existingNames select: [ :imageName | imageName beginsWith: baseName ].
	existingUniquifiers := similarbaseImageNames
		collect: [ :imageName | 
			| suffix |
			suffix := imageName allButFirst: baseName size.
			(suffix beginsWith: separator)
				ifTrue: [ (suffix allButFirst: separator size) initialIntegerOrNil ]
				ifFalse: 0 ]
		thenSelect: #notNil.
	existingUniquifiers ifEmpty: [ ^ baseName ].
	nextUniquifier := existingUniquifiers max + 1.
	^ baseName , separator , (nextUniquifier printPaddedWith: $0 to: 2)