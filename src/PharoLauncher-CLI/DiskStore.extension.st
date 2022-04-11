Extension { #name : #DiskStore }

{ #category : #'*PharoLauncher-CLI' }
DiskStore class >> currentFileSystem: fileSystem during: aBlock [
	| backupFileSystem |
	backupFileSystem := self currentFileSystem.
	[ CurrentFS := fileSystem.
	aBlock value ]
		ensure: [  CurrentFS:= backupFileSystem ]
]
