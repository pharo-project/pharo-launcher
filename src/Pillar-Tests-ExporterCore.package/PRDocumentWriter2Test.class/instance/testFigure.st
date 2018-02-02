tests
testFigure
	| html |
	html := PRExternalLink new
		reference: 'file://picture.png';
		embedded: true;
		yourself.
	self
		assertWriting: html
		includesTexts:
			{(self figureBegin).
			'picture.png'}