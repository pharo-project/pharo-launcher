tests
testTableWithHeading
	| html |
	html := PRTable new
		add:
				(PRTableRow new
						add:
								(self
										addText: 'foo'
										to:
											(PRTableCell new
												beHeading;
												yourself));
						yourself);
		yourself.
	self
		assertWriting: html
		includesTexts:
			{(self tableBegin).
			(self tableRow).
			(self tableCellWithHeadingFoo)}