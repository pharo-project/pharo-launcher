initialization
initializeToolbar
	"Only called once. A button is created for each command class."
	self widgets removeAll.
	self instantiateModels: self buildButtonWidgetsSpec.
	self buttonsDo: [ :button :commandClass | button setCommandClass: commandClass ].
	self setFocusOrder.
	self needFullRebuild: true.
	self needRebuild: false.
	self buildWithSpecLayout: self dynamicLayout