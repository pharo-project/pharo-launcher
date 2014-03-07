initialization
initializeWidgets
	title := self newLabel
		text: '';
		yourself.
	tree := self newTree
		menu: [ :menu | self buildMenu: menu ];
		displayBlock: [ :item | item name ];
		doubleClick: [ self doubleClick ];
		hasChildrenBlock: [ :item | item hasChildren ];
		childrenBlock: [ :item | item children ].
	toolbar := self newCommandToolbar.
	tree whenSelectedItemsChanged: [ self context ifNotNil: [ self updateContext ] ]