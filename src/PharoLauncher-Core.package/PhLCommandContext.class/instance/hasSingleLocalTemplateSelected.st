testing selection
hasSingleLocalTemplateSelected
	^ (selection size = 1) and: [ selection anyOne isLocalTemplate ]