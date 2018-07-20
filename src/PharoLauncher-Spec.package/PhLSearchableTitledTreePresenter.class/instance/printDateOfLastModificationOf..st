printing
printDateOfLastModificationOf: anItem
	| text date delta |
	date := anItem content file modificationTime.
	text := self dateDisplayStrategy displayStringOf: date.
	self displayColorsForDate
		ifTrue: [ text makeAllColor: Color darkGray.
			delta := DateAndTime now - date.
			delta days < 31
				ifTrue: [ text makeAllColor: Color orange ].
			delta days < 8
				ifTrue: [ text makeAllColor: Color green muchDarker ].
			delta days < 3
				ifTrue: [ text makeAllColor: Color green darker] ].
	^ text asMorph lock