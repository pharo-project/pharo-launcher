private
cleaningFilesFrom: aDirectory
	"Remove all files in aDirectory except the files representing the image"
	aDirectory children
		do: [ :aFile | 
			(('*.image' match: aFile basename) or: [ '*.changes' match: aFile basename ])
				ifFalse: [ aFile deleteAll ] ]