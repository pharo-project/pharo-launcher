tests
testReferenceToHeaderAnchor
	| html resultString indexOfReference referenceString |
	html := PRDocument new
		add:
				(PRHeader new
						level: 1;
						add: (PRText content: 'foo');
						yourself);
		add: (PRAnchor named: 'chap:foo');
		add:
				(PRParagraph new
						add: (PRText content: 'See Chapter ');
						add:
								(PRInternalLink new
										reference: 'chap:foo';
										yourself);
						yourself);
		yourself.
	resultString := self write: html.
	indexOfReference := resultString indexOfSubCollection: 'See Chapter ' startingAt: 1 ifAbsent: [ self fail: 'The string ''See Chapter '' should have been found' ].
	referenceString := resultString allButFirst: indexOfReference - 1.
	self assert: referenceString includesSubstring: self counter1ReferenceString