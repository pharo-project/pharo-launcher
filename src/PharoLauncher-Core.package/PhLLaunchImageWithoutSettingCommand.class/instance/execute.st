action
execute
	context singleImage launchWithoutSetting: self vmToUse.
	self class quitOnLaunch
		ifTrue: [ self quit ]