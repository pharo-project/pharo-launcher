initialization
initializeWidgets
	title := self newLabel
		text: '';
		yourself.
	tree := self newTree
		menu: [ :menu :shifted | self buildMenu: menu shifted: shifted ];
		displayBlock: [ :item | item name ];
		doubleClick: [ self doubleClick ].
	toolbar := self newCommandToolbar.
	tree whenSelectedItemsChanged: [ self context ifNotNil: [ self updateContext ] ]