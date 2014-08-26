accessing
pathNames
	^ self selections collect: [ :path | 
			| result |
			result := WriteStream on: String new.
			path doWithIndex: [:node :i|
				 i > 1 ifTrue: [ result nextPut: $- ].
				 result nextPutAll: node content name].
			result contents asFileName ]
		