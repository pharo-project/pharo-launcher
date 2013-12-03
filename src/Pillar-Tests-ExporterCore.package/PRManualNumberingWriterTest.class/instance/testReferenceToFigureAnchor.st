tests
testReferenceToFigureAnchor
	| html resultString indexOfReference referenceString |
	html := PRDocument new
	add: (PRHeader new
						level: 1;
						add: (PRText content: 'foo');
						yourself);
	add: (PRParagraph new
		add:
				(PRExternalLink new
						reference: 'file://picture.png';
						parameterAt: 'label' put: 'fig:picture';
						embedded: true;
						yourself);
		add: (PRText content: 'See Figure ');
		add:
				(PRInternalLink new
						reference: 'fig:picture';
						yourself);
		yourself).
	resultString := self write: html.
	indexOfReference := resultString
		indexOfSubCollection: 'See Figure '
		startingAt: 1
		ifAbsent: [ self fail: 'The string ''See Figure '' should have been found' ].
	referenceString := resultString allButFirst: indexOfReference - 1.
	self assert: referenceString includesSubstring: self counter11ReferenceString