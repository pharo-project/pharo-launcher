accessing
repository: aRepository
	self assert: self repository isNil description: 'Changing the repository is not allowed because we would have to change the context as well'.
	repositoryHolder contents: aRepository.
	self repository whenChangedSend: #refresh to: self.
	self refresh