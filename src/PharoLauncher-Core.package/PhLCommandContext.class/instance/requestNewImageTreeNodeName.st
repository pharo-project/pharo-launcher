user interaction
requestNewImageTreeNodeName
	^ self newRequest
		title: 'Image group name?';
		initialAnswer: (self makeUniqueImageTreeNodeName: self defaultImageTreeNodeName);
		validateAnswer: [ :answer | (self hasImageTreeNodeNamed: answer) not ];
		request