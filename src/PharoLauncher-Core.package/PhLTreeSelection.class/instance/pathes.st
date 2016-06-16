accessing
pathes
	^ self selections collect: [ :path | 
			| result |
			result := OrderedCollection new: 5.
			self pathFor: path on: result.
			result ]
		