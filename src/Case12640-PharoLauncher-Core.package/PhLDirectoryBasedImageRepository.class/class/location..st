accessing
location: directory
	self location ~= directory
		ifTrue: [ 
			self migrateFrom: self location to: directory.
			Location := directory.
			self default contentsChanged ]