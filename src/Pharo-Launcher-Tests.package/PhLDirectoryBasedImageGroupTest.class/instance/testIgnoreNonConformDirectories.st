instance-creation
testIgnoreNonConformDirectories
	| group baseDirectory |
	group := self emptyGroup.
	baseDirectory := group baseDirectory.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1') ensureDirectory.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo.txt') ensureFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') ensureFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') delete.
	(baseDirectory / 'foo1' / 'foo1.changes') ensureFile.
	self assert: group images size equals: 0.
		(baseDirectory / 'foo1' / 'foo1.image') ensureFile.
	self assert: group images size equals: 1.