action
makeUniqueTemplateName: baseTemplateName among: existingTemplateNames
	"Provide a reasonable default template name using the next incremental count for images with similar basenames"

	"See #testMakeUniqueImageName for samples"

	| similarbaseImageNames existingUniquifiers nextUniquifier separator |
	separator := '-'.
	similarbaseImageNames := existingTemplateNames select: [ :imageName | imageName beginsWith: baseTemplateName ].
	existingUniquifiers := similarbaseImageNames
		collect: [ :imageName | 
			| suffix |
			suffix := imageName allButFirst: baseTemplateName size.
			(suffix beginsWith: separator)
				ifTrue: [ (suffix allButFirst: separator size) initialIntegerOrNil ]
				ifFalse: 0 ]
		thenSelect: #notNil.
	existingUniquifiers ifEmpty: [ ^ baseTemplateName ].
	nextUniquifier := existingUniquifiers max + 1.
	^ baseTemplateName , separator , (nextUniquifier printPaddedWith: $0 to: 2)