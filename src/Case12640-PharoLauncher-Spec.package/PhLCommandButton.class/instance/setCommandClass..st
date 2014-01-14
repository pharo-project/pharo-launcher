initialize
setCommandClass: aCommandClass
	commandClass := aCommandClass.
	self
		help: commandClass title;
		icon: commandClass icon;
		state: false