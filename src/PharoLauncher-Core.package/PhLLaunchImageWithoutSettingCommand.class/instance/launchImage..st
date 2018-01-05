action
launchImage: aPhLImage
	aPhLImage launchWithoutSetting.
	self class quitOnLaunch
		ifTrue: [ self quit ]