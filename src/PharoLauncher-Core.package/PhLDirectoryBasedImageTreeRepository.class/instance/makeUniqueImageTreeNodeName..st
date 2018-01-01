accessing
makeUniqueImageTreeNodeName: aString 
	^ self makeUniqueImageName: aString among: self imageNames.