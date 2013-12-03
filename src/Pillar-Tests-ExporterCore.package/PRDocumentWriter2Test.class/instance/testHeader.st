tests
testHeader
	| html |
	html := PRHeader new
		level: 1;
		add: (PRText content: 'foo');
		yourself.
	self assertWriting: html includesTexts: {self level1HeaderBegin . self foo}.
	self configuration headingLevelOffset: 2.
	self assertWriting: html includesTexts: {self level3HeaderBegin . self foo}