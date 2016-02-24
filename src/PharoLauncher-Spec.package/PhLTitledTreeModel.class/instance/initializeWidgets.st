initialization
initializeWidgets
	title := self newLabel
		label: '';
		yourself.
	tree := self newTree
		menu: [ :menu | self buildMenu: menu ];
		displayBlock: [ :item | item name ];
		doubleClick: [ self doubleClick ];
		hasChildrenBlock: [ :item | item hasChildren ];
		childrenBlock: [ :item | item children ].
	tree whenBuiltDo:[:t | t widget widget
		rowColorForEven: self theme backgroundColor lighter odd: self theme backgroundColor darker].
	toolbar := self newCommandToolbar.
	tree whenSelectedItemsChanged: [ self context ifNotNil: [ self updateContext ] ]