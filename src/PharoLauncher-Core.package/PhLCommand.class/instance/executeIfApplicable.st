action
executeIfApplicable
	self isApplicable ifTrue: [ 
		self validateModelIntegrity ifTrue: [self executeCommand ]]