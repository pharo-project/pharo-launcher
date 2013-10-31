updating
updateRepository
	"Call me when a new repository is passed to the receiver"
	self repository whenChangedSend: #refresh to: self.
	self refresh.
	