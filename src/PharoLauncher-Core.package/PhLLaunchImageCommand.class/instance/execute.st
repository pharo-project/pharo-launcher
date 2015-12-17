action
execute
	self needsSpurVm ifTrue: [ 
		context singleImage launch: self class spurFullPath ]
	ifFalse:[
		context singleImage launch: self class vmFullPath].
	self class quitOnLaunch
		ifTrue: [ self quit ]