accessing
imageTreeNodes
	| parentNodes |
	parentNodes := OrderedCollection new.
	self baseDirectory directories
		do: [ :directory | (self treeNodeFromDirectory: directory) ifNotNil: [ :node | parentNodes add: node ] ].
	^ parentNodes