initialization
setCommandClasses: aCollection
	"Call this when the toolbar widget is present but not yet filled with buttons. Each command class in the collection will be represented by a dedicated button in the toolbar"
	commandClasses := aCollection.
	self
		assert: commandClasses size = (commandClasses collect: #specId) asSet size
		description: 'You can''t add 2 commands with the same #specId on the same toolbar'.
	self initializeToolbar.