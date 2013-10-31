accessing
commandClasses: aCollection
	"Each command class in the collection will be represented by a dedicated button in the toolbar"

	self
		assert: aCollection size = (aCollection collect: #specId) asSet size
		description: 'You can''t add 2 commands with the same #specId on the same toolbar'.
	commandClassesHolder contents: aCollection