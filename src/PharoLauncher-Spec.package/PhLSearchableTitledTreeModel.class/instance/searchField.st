private - accessing
searchField
	
	^ search ifNil: [ search := self newSearchField ]