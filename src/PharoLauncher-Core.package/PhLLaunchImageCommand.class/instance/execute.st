action
execute
	context singleImage launch: self vmToUse.
	self class quitOnLaunch
		ifTrue: [ self quit ]