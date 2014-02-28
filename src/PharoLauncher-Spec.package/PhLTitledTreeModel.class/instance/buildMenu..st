private
buildMenu: menu
	| currentGroupNumber currentGroup |
	currentGroupNumber := nil.
	currentGroup := MenuGroupModel new.
	menu
		title: '  Pharo Launcher';
		icon: Smalltalk ui icons pharoIcon;
		addMenuGroup: currentGroup.
	commandClasses
		do: [ :commandClass | 
			| command |
			command := commandClass on: self context.
			command isApplicable
				ifTrue: [ 
					(currentGroupNumber notNil and: [ currentGroupNumber ~= command group ])
						ifTrue: [ 
							currentGroup := MenuGroupModel new.
							menu addMenuGroup: currentGroup ].
					currentGroup addMenuItem: command asMenuItem.
					currentGroupNumber := command group ] ]