user interaction
requestNewTemplateName: aString 
	^ self newRequest
		title: 'Template name?';
		initialAnswer: (self makeUniqueTemplateName: aString);
		validateAnswer: [ :answer | (self hasTemplateNamed: answer) not ];
		request