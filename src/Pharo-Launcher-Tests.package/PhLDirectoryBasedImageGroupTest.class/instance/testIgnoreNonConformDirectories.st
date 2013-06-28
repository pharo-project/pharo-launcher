instance-creation
testIgnoreNonConformDirectories
	| group baseDirectory |
	group := self emptyGroup.
	baseDirectory := group baseDirectory.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1') ensureCreateDirectory.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo.txt') ensureCreateFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') ensureCreateFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') delete.
	(baseDirectory / 'foo1' / 'foo1.changes') ensureCreateFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') ensureCreateFile.
	self assert: group images size equals: 1.