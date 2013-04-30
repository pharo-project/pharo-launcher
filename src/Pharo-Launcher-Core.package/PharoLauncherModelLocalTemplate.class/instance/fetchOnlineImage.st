as yet unclassified
fetchOnlineImage

	self listElement: OrderedCollection new.
	(FileList new directory: self url) fileList do:[ :each |
		self listElement add: (self fetchOnlineImage: each)].