private
doubleClick
	"Call me when a user double clicks on an item. I will execute the doubleClickCommandClass."
	self doubleClickCommandClass
		ifNotNil: [ :commandClass | 
			| command |
			command := commandClass on: self context.
			command executeIfApplicable ]