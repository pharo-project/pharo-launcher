accessing
pathNames
	^ self selections collect: [ :path | 
			| result |
			result := WriteStream on: String new.
			
			self pathNameFor: path on: result.
			
			result contents asFileName ]
		