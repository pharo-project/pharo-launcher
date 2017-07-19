action
execute
	context singleImage launchWithoutSetting.
	self class quitOnLaunch
		ifTrue: [ self quit ]