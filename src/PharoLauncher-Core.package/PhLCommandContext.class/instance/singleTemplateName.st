selection
singleTemplateName
	self
		ensure: self hasSingleTemplateSelected.
		
	^ (selection pathNames anyOne splitOn: '-(') first