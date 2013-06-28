tests
testRelocateImageFilesFromToWithName
	| template source destination imageName |
	template := self newTemplate.
	source := (root / 'old') ensureCreateDirectory.
	destination := (root / 'new') ensureCreateDirectory.
	(source / 'file.image') ensureCreateFile.
	(source / 'file.changes') ensureCreateFile.
	imageName := 'new'.
	self deny: (destination / imageName , 'image') exists.
	self deny: (destination / imageName , 'changes') exists.
	template relocateImageFilesFrom: source to: destination withName: imageName.
	self assert: (destination / imageName , 'image') exists.
	self assert: (destination / imageName , 'changes') exists