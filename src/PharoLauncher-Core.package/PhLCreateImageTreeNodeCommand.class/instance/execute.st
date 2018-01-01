action
execute
	| name |
	name := self newImageTreeNodeName , context imageRepository treeNodeDirectoryExtension.
	name ifNil: [ ^ self ].
	self ensure: (context isNewImageTreeNodeNameValid: name).
	context imageRepository createImageTreeNodeFrom: name