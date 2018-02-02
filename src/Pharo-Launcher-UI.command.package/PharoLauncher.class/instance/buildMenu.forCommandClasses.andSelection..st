menu
buildMenu: menu forCommandClasses: commandClasses andSelection: aSelection
	| context |
	context := PhLCommandContext
		selection: aSelection
		imageRepository: self imageRepository
		templateRepository: self templateRepository.
	menu addTitle: '  Pharo Launcher   ' icon: Smalltalk ui icons pharoIcon.
	commandClasses
		do: [ :commandClass | 
			| command |
			command := commandClass on: context.
			command isApplicable
				ifTrue: [ menu addMenuItem: command asMenuItem ] ]