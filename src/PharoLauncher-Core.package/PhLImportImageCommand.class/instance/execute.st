action
execute
	| imagePath |
	imagePath := UIManager default 
		chooseFullFileName: 'Import a Pharo image (will move it to Pharo Launcher images store)'
		extensions: #('image') 
		path: FileLocator home 
		preview: false.
	imagePath ifNil: [ ^ self ].
	imagePath asFileReference isDirectory ifTrue: [ ^ self ].
	self import: imagePath