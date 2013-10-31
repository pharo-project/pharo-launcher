accessing
repository: aRepository
	self repository ifNotNil: [ :repository | repository unsubscribe: self ].
	repositoryHolder contents: aRepository.
	self repository whenChangedSend: #refresh to: self.