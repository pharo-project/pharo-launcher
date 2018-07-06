private
pathFor: treeNodeModel on: collection

	| content |

	treeNodeModel parentNode ifNotNil: 
		[ :node |
		self pathFor: node on: collection ].
		
	content := treeNodeModel content.
	collection add: (content isString
		ifTrue: [ content printString ]
		ifFalse: [ content name ])
