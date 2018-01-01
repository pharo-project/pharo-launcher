testing selection
hasSingleImageTreeNodeSelected
	^ (selection size = 1) and: [ selection anyOne isImageTreeNode ]