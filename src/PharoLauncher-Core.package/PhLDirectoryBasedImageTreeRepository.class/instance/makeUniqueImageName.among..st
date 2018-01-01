accessing
makeUniqueImageName: baseName among: existingNames
	"Provide a reasonable default image folder name using the next incremental count for image folders with similar basenames"

	^ self makeUniqueName: baseName among: existingNames