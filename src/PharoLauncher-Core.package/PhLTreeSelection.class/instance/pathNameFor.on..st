private
pathNameFor: treeNodeModel on: writeStream
	| content |
	treeNodeModel parentNode
		ifNotNil: [ :node | 
			self pathNameFor: node on: writeStream.
			writeStream nextPut: $- ].
	content := treeNodeModel content.
	writeStream
		nextPutAll:
			(content isString
				ifTrue: [ content printString ]
				ifFalse: [ content name ])