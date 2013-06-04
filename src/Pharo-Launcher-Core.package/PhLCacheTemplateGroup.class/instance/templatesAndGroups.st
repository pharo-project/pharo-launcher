accessing
templatesAndGroups
	^ templatesAndGroups ifNil: [ templatesAndGroups := delegate templatesAndGroups ]