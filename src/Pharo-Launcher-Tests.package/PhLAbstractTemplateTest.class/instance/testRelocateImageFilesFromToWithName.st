tests
testRelocateImageFilesFromToWithName
	| template source destination imageName |
	template := self newTemplate.
	source := (root / 'old') ensureDirectory.
	destination := (root / 'new') ensureDirectory.
	(source / 'file.image') ensureFile.
	(source / 'file.changes') ensureFile.
	imageName := 'new'.
	self deny: (destination / imageName , 'image') exists.
	self deny: (destination / imageName , 'changes') exists.
	template relocateImageFilesFrom: source to: destination withName: imageName.
	self assert: (destination / imageName , 'image') exists.
	self assert: (destination / imageName , 'changes') exists