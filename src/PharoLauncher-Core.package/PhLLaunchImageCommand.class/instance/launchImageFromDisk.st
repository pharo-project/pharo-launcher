action
launchImageFromDisk
	| imagePath |
	imagePath := UIManager default 
		chooseFullFileName: 'Open a Pharo image'
		extensions: #('image') 
		path: FileLocator home 
		preview: false.
	imagePath ifNil: [ ^ self ].
	self launchImage: (PhLImage location: imagePath asFileReference)