initialization
initialize
	"Must be run before any write acess to the file system.
	UI should already be usable!"
	"SessionManager default 
		register: (ClassSessionHandler forClassNamed: self name)
		inCategory: SessionManager default toolsCategory
		atPriority: 1"