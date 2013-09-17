actions
closeAllWindows
	"We make sure we always close without asking for confirmation. It looks like #closeAllWindowsDiscardingChanges doesn't work as a startup action."
	[ World closeAllWindowsDiscardingChanges ]
		on: ProvideAnswerNotification
		do: [ :err | err return: false ]