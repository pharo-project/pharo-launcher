instance-creation
newGroupWithAnImage
	| group baseDirectory |
	group := self emptyGroup.
	baseDirectory := group baseDirectory.
	(baseDirectory / 'test') ensureCreateDirectory.
	(baseDirectory / 'test' / 'test.image') ensureCreateFile.
	(baseDirectory / 'test' / 'test.changes') ensureCreateFile.
	^ group