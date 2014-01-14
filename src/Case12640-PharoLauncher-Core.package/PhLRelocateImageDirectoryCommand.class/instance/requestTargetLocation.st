user interaction
requestTargetLocation
	^ PhLUIRequest new
		initialAnswer: self source;
		title: 'New location for your images';
		validateAnswer: [ :answer | answer asFileReference ~= self source ];
		request