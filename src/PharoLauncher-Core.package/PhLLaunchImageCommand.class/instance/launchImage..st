action
launchImage: aPhLImage
	[ [ aPhLImage launchWithSettings: true ]
		on: PhLArchitectureMismatchWarning 
		do: [ :warning | | continue |
				continue := UIManager default confirm: warning longDescription label: warning name.
				continue ifTrue: [ warning resume ].
				 ] ]
		on: PhLError
		do: [ :error | error uiAlert ].
	self class quitOnLaunch
		ifTrue: [ self quit ]