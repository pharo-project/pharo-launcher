action
execute
	self source children collect: [ :child | child moveTo: (self target resolvePath: (child relativeTo: self source)) resolve ] 