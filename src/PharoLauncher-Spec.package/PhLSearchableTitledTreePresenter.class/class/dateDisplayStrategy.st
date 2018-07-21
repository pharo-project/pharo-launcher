accessing
dateDisplayStrategy
	^ DateDisplayStrategy ifNil: [ DateDisplayStrategy := PhLTimeUntilNowStrategy ]