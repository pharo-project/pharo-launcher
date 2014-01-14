instance creation
allConcreteCommandsOn: aContext
	^ self allConcreteCommands collect: [ :cls | cls on: aContext ]