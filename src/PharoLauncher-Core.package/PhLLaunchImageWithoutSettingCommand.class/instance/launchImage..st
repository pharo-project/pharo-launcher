action
launchImage: aPhLImage
	aPhLImage launchWithSettings: false.
	self class quitOnLaunch
		ifTrue: [ self quit ]