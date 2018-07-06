private
pathNameFor: treeNodeModel on: writeStream

		treeNodeModel parentNode ifNotNil: [ :node |
			self pathNameFor: node on: writeStream.
			writeStream nextPut: $- ].
		
		writeStream nextPutAll: treeNodeModel content name