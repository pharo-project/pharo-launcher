user interaction
requestNewTemplateName: aString 
	^ self newRequest
		title: 'Template name?';
		initialAnswer: (self makeUniqueTemplateName: aString);
		validateAnswer: [ :answer | 
			(self hasTemplateNamed: answer) 
				ifTrue: [ UIManager default confirm: 'Do you want to override exisiting template?' ]
				ifFalse: [ true ] ];
		request