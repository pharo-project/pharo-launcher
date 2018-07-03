accessing
repository: aRepository
	self assert: self repository isNil description: 'Changing the repository is not allowed because we would have to change the context as well'.
	repositoryHolder value: aRepository.
	self repository whenChangedSend: #refresh to: self.
	self whenChangedDo: [ :w | w whenClosedDo: [ self repository unsubscribe: self ] ].
	self refresh