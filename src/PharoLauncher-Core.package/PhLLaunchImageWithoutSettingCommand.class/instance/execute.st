action
execute
	self needsSpurVm ifTrue: [ 
		context singleImage launchWithoutSetting: self class spurFullPath ]
	ifFalse:[
		context singleImage launchWithoutSetting: self class vmFullPath].
	self class quitOnLaunch
		ifTrue: [ self quit ]