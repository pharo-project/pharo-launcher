as yet unclassified
fetchOnlineImage

	self listElement: OrderedCollection new.
	(FileList new directory: self url) fileList do:[ :each |
		self listElement addAll: (self fetchOnlineImage: each)].