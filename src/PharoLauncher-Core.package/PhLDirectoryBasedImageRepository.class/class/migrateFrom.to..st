private
migrateFrom: oldLocation to: newLocation
	| command |
	command := PhLRelocateImageDirectoryCommand new
		source: oldLocation;
		target: newLocation;
		executeOrInform