action
execute

	context singleImage launch: self class vmFullPath.
	self class quitOnLaunch
		ifTrue: [ self quit ]