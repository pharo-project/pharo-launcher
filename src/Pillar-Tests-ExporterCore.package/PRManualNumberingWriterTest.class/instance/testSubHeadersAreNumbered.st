tests
testSubHeadersAreNumbered
	| html |
	html := PRDocument new
		add:
				(PRHeader new
						level: 1;
						add: (PRText content: 'foo');
						yourself);
		add:
				(PRHeader new
						level: 2;
						add: (PRText content: 'foo');
						yourself);
		yourself.
	self
		assertWriting: html
		includesTexts:
			{(self counter1DefinitionString).
			(self counter11DefinitionString)}