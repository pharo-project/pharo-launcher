testing selection
hasSingleTemplateSelected
	^ (selection size = 1) and: [ selection anyOne isTemplate ]