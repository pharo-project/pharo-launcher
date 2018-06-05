action
launchImage: aPhLImage
	[ aPhLImage launchWithSettings: true ]
		on: PhLError
		do: [ :error | error uiAlert ].
	self class quitOnLaunch
		ifTrue: [ self quit ]