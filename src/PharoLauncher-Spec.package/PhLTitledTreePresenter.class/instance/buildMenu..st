private
buildMenu: menu
	| currentGroupNumber currentGroup |
	currentGroupNumber := nil.
	currentGroup := MenuGroupPresenter new.
	menu
		title: '  Pharo Launcher';
		icon: (self iconNamed: #pharoIcon);
		addMenuGroup: currentGroup.
	commandClasses
		do: [ :commandClass | 
			| command |
			command := commandClass on: self context.
			command isApplicable
				ifTrue: [ 
					(currentGroupNumber notNil and: [ currentGroupNumber ~= command group ])
						ifTrue: [ 
							currentGroup := MenuGroupPresenter new.
							menu addMenuGroup: currentGroup ].
					currentGroup addMenuItem: command asMenuItem.
					currentGroupNumber := command group ] ]