private
pathFor: treeNodeModel on: collection

		treeNodeModel parentNode ifNotNil: 
			[ :node |
			self pathFor: node on: collection ].
		
		collection add: treeNodeModel content name