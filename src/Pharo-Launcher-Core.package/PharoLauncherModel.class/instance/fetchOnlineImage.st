items creation
fetchOnlineImage
	
	self listElement: OrderedCollection new.
	self listElement addAll: (self fetchOnlineImage: self url)