"
I can be used to import an image into Pharo Launcher.

I move the image file and its associated changes file to the default location of Pharo Launcher images store.
"
Class {
	#name : #PhLImportImageCommand,
	#superclass : #PhLImageCommand,
	#instVars : [
		'importSiblings'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLImportImageCommand class >> group [
	^ 4
]

{ #category : #accessing }
PhLImportImageCommand class >> icon [
	^ self iconNamed: #smallLoadProject 
]

{ #category : #accessing }
PhLImportImageCommand class >> title [
	^ 'Import'
]

{ #category : #action }
PhLImportImageCommand >> execute [
	| answer |
	importSiblings := false.
	answer := UIManager default
		chooseFrom:
			{ 'Launch an image from the file system' . 
			'Import an image into Pharo Launcher images store (will move files)' .
			'Import the image directory (and all files it contains) into Pharo Launcher images store (will move files)' }
		lines: #()
		title: 'What would you like to do?'.
	answer = 3
		ifTrue:	[ importSiblings := true ].
	(answer = 2 or: [ answer = 3 ])
		ifTrue:	[ self importImage ].
	answer = 1 
		ifTrue: [ (PhLLaunchImageCommand on: self model) launchImageFromDisk ].
]

{ #category : #action }
PhLImportImageCommand >> import: imagePath [
	| infoMessage destFolderName |
	destFolderName := imagePath asFileReference basenameWithoutExtension.
	importSiblings 
		ifTrue: [ self model imageRepository
			importImageNamed: imagePath
			 andSiblingFilesto: destFolderName ]
		ifFalse: [ self model imageRepository
			importImageNamed: imagePath
			to: destFolderName ].
	infoMessage := 'Image ' , imagePath , ' imported!'.
	self inform: (infoMessage withNoLineLongerThan: 60) 
]

{ #category : #action }
PhLImportImageCommand >> importImage [
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
]

{ #category : #testing }
PhLImportImageCommand >> isApplicable [
	^ true
]
