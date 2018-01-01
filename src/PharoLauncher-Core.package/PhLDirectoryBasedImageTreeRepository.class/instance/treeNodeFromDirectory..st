private
treeNodeFromDirectory: aDirectory
	^ (aDirectory fullName endsWith: self treeNodeDirectoryExtension)
		ifTrue: [ PhLDirectoryBasedImageTreeRepository forDirectory: aDirectory ]
		ifFalse: [ nil ]