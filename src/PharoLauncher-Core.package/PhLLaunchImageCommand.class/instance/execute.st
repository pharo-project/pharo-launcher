action
execute
	context singleImage launch.
	self class quitOnLaunch
		ifTrue: [ self quit ]