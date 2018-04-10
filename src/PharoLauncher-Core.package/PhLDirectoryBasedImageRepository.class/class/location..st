accessing
location: directory
	self location = directory
		ifFalse: [ 
			self migrateFrom: self location to: directory.
			Location := directory.
			self default contentsChanged ]