action
makeUniqueTemplateName: baseTemplateName among: existingTemplateNames
	"Provide a reasonable default template name using the next incremental count for images with similar basenames"

	"See #testMakeUniqueImageName for samples"

	^ self makeUniqueName: baseTemplateName among: existingTemplateNames