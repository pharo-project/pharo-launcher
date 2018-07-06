initialization
updateContext
	"Call me when a new context is passed to the receiver or when the selection of my tree changes"

	super updateContext.
	
	selectionChangedBlock
		ifNotNil: [ selectionChangedBlock cull: tree selectedItems ]