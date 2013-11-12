private
buildMenu: menu shifted: shifted
	| currentGroup |
	currentGroup := nil.
	menu addTitle: '  Pharo Launcher   ' icon: Smalltalk ui icons pharoIcon.
	commandClasses
		do: [ :commandClass | 
			| command |
			command := commandClass on: self context.
			command isApplicable
				ifTrue: [ 
					(currentGroup notNil and: [ currentGroup ~= command group ])
						ifTrue: [ menu addLine ].
					menu addMenuItem: command asMenuItem.
					currentGroup := command group ] ]