system startup
startUp
	self startUpClasses do: [ :c | c launcherStartUp ]