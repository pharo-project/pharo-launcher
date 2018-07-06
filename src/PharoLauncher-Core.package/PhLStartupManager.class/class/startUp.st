system startup
startUp
	self startUpClasses do: [ :c | c ifNotNil: [ c launcherStartUp ] ]