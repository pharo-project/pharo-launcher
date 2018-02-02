updating
updateCommandClasses
	"We just got new command classes to display. We have to recreate all the buttons"

	self widgets removeAll.
	self instantiateModels: self buildButtonWidgetsSpec.
	self buttonsDo: [ :button :commandClass | button setCommandClass: commandClass ].
	self setFocusOrder.
	self needFullRebuild: true.
	self needRebuild: false.
	self buildWithSpecLayout: self dynamicLayout