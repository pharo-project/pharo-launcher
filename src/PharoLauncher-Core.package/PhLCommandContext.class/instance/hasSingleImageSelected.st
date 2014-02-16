testing selection
hasSingleImageSelected
	^ (selection size = 1) and: [ selection anyOne isImage ]