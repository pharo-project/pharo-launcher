private
migrateFrom: oldLocation to: newLocation
	(self forDirectory: oldLocation) hasImages
		ifTrue: [ 
			| command |
			command := PhLRelocateImageDirectoryCommand new
				source: oldLocation;
				target: newLocation;
				executeOrInform ]