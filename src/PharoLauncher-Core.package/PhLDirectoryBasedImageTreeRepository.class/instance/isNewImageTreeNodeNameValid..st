testing
isNewImageTreeNodeNameValid: aString 
	^ aString notEmpty and: [ aString endsWith: self treeNodeDirectoryExtension ]