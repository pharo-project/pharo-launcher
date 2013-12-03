tests
testTableWith2CellsInARow
	| html |
	html := PRTable new
		add:
				(PRTableRow new
						add: (self addText: 'foo' to: PRTableCell new);
						add: (self addText: 'foo' to: PRTableCell new);
						yourself);
		yourself.
	self
		assertWriting: html
		includesTexts:
			{(self tableBegin).
			(self tableRow).
			(self tableCellWithFoo)}.
	^ html