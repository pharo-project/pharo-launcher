actions
cleaningFilesFrom: aDirectory
	
	aDirectory children do: [ :aFile | (('*.image' match: aFile basename) | ('*.changes' match: aFile basename))
		ifFalse: [ aFile deleteAll ]]. 
	