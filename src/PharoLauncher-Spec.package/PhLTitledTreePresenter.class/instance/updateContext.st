updating
updateContext
	"Call me when a new context is passed to the receiver or when the selection of my tree changes"

	| contextWithSelection |
	contextWithSelection := self context withNewSelection: (PhLTreeSelection with: tree selectedItems).
	
	self context: contextWithSelection.
	toolbar context: contextWithSelection.