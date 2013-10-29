user interface
requestNewImageName: aString 
	^ self newRequest
		title: 'Image name?';
		initialAnswer: (self makeUniqueImageName: aString);
		validateAnswer: [ :answer | (self hasImageNamed: answer) not ];
		request