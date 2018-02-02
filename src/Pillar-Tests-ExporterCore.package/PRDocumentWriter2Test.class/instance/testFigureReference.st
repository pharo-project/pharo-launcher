tests
testFigureReference
	| html resultString indexOfReference referenceString |
	html := PRParagraph new
		add:
				(PRExternalLink new
						reference: 'file://picture.png';
						embedded: true;
						parameterAt: 'label' put: 'pierLogo';
						yourself);
		add: (PRText content: 'See figure ');
		add: (PRInternalLink reference: 'pierLogo');
		yourself.
		resultString := self write: html.
	indexOfReference := resultString indexOfSubCollection: 'See figure ' startingAt: 1 ifAbsent: [ self fail: 'The string ''See figure '' should have been found' ].
	referenceString := resultString allButFirst: indexOfReference - 1.
	self assert: referenceString includesSubstring: self referenceToFigurePierLogo