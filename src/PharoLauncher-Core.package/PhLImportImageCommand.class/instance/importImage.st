action
importImage
	| imagePath |
	imagePath := UIManager default
		chooseFullFileName: 'Import a Pharo image (will move image, changes file and pharo-local folder)'
		extensions: #('image')
		path: FileLocator home
		preview: false.
	imagePath ifNil: [ ^ self ].
	imagePath asFileReference isDirectory
		ifTrue: [ ^ self ].
	self import: imagePath