instance-creation
newGroupWithAnImage
	| group baseDirectory |
	group := self emptyGroup.
	baseDirectory := group baseDirectory.
	(baseDirectory / 'test') ensureDirectory.
	(baseDirectory / 'test' / 'test.image') ensureFile.
	(baseDirectory / 'test' / 'test.changes') ensureFile.
	^ group