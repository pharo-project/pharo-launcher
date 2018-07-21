accessing
allStrategiesWithNames
	^ self allStrategies collect: [ :each | each label -> each ]