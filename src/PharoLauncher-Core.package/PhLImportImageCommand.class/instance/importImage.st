action
importImage
	| imagePath |
	imagePath := UIManager default
		chooseFullFileName: 'Import a Pharo image (will move image, changes file and pharo-local folder)'
		extensions: #('image')
		path: FileLocator home
		preview: false.
	imagePath ifNil: [ 
		self inform: 'No path selected. Import failed.'.
		^ self ].
	imagePath asFileReference isDirectory ifTrue: [ 
		self inform: 'The file selected is a directory and not a Pharo image. Import failed.'.
		^ self ].
	self import: imagePath