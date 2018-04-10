action
makeUniqueImageName: baseImageName among: existingImageNames
	"Provide a reasonable default image name using the next incremental count for images with similar basenames"

	"See #testMakeUniqueImageName for samples"

	^ self makeUniqueName: baseImageName among: existingImageNames