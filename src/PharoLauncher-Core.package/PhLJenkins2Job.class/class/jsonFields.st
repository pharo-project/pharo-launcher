protected
jsonFields
	^ {'name'.
	'url'.
	('lastSuccessfulBuild[' , PhLJenkins2Build jsonFieldsQuery , ']')}