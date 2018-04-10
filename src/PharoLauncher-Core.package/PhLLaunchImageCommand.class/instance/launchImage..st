action
launchImage: aPhLImage
	aPhLImage launchWithSettings: true.
	self class quitOnLaunch
		ifTrue: [ self quit ]