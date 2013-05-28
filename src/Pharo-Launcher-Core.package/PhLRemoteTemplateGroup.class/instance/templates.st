accessing
templates
	^ templates ifNil: [ self downloadTemplateList. templates ]