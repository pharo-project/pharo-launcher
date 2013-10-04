action
makeUniqueImageName: baseImageName
	^ self makeUniqueImageName: baseImageName among: self imageNames.