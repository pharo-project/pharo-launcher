private
buildMenu: menu shifted: shifted
	menu addTitle: '  Pharo Launcher   ' icon: Smalltalk ui icons pharoIcon.
	self commandClasses
		do: [ :commandClass | 
			| command |
			command := commandClass on: self context.
			command isApplicable
				ifTrue: [ menu addMenuItem: command asMenuItem ] ]