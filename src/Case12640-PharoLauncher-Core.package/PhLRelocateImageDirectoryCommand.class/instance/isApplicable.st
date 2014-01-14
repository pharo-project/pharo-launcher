testing
isApplicable
	self target ensureCreateDirectory.
	^ self source ~= self target and: [ self source hasChildren and: [ self target hasChildren not ] ]