action
launchImageFromDisk
	| imagePath |
	imagePath := UIManager default 
		chooseFullFileName: 'Open a Pharo image'
		extensions: #('image') 
		path: FileLocator home 
		preview: false.
	self launchImage: (PhLImage location: imagePath asFileReference)