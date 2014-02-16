updating
updateContext
	"Call me when a new context is passed to the receiver or when the selection of my tree changes"

	self context: (self context withNewSelection: (tree selectedItems collect: #content)).
	toolbar context: self context