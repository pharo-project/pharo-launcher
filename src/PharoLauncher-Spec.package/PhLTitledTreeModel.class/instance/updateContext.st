updating
updateContext
	"Call me when a new context is passed to the receiver or when the selection of my tree changes"

	self context: (self context withNewSelection: (PhLTreeSelection  with: (tree selectedItems collect: #nodePath))).
	toolbar context: self context