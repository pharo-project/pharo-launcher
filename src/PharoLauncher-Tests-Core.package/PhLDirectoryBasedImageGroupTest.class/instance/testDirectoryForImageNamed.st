instance-creation
testDirectoryForImageNamed
	| group |
	group := self emptyGroup.
	self assert: group images isEmpty.
	self assert: group imageNames isEmpty.