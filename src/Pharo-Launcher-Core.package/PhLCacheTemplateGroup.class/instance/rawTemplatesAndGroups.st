accessing
rawTemplatesAndGroups
	^ delegate templatesAndGroups
			sorted: [ :t1 :t2 | t1 name > t2 name ]