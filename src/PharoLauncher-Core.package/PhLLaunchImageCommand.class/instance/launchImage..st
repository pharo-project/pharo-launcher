action
launchImage: aPhLImage
	aPhLImage launch.
	self class quitOnLaunch
		ifTrue: [ self quit ]