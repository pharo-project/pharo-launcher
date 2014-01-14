private
migrateFrom: oldLocation to: newLocation
	(oldLocation exists and: [ (self forDirectory: oldLocation) hasImages ])
		ifTrue: [ 
			| command |
			command := PhLRelocateImageDirectoryCommand new
				source: oldLocation;
				target: newLocation;
				executeOrInform ]