"
I can be used to import an image into Pharo Launcher.

I move the image file and its associated changes file to the default location of Pharo Launcher images store.
"
Class {
	#name : 'PhLImportImageCommand',
	#superclass : 'PhLImageCommand',
	#instVars : [
		'importSiblings'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'accessing' }
PhLImportImageCommand class >> imageFilesIn: aDirectory [

	^ (aDirectory children select: [ :child | child isFile and: [ child extension asLowercase = 'image' ] ]) asSortedCollection: [ :first :second | first basename <= second basename ]
]

{ #category : 'converting' }
PhLImportImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallLoadProject;
		shortcutKey: $y actionModifier;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : 'ui interaction' }
PhLImportImageCommand >> askToImportSiblings [

	| options answer |
	options := { 'Import an image into Pharo Launcher images store (will move files)'. 'Import the image directory (and all files it contains) into Pharo Launcher images store (will move files)' }.
	answer := self imagesPresenter newChoice
		          title: 'Import';
		          message: 'What would you like to do?';
		          items: options;
		          run.
	^ answer ifNotNil: [ (options indexOf: answer) = 2 ]
]

{ #category : 'accessing' }
PhLImportImageCommand >> canBeExecuted [
	^ true
]

{ #category : 'ui interaction' }
PhLImportImageCommand >> chooseImageAmong: imageFiles [

	| chosenName |
	chosenName := self imagesPresenter newChoice
		              title: 'Import';
		              message: 'Which image would you like to import?';
		              items: (imageFiles collect: [ :imageFile | imageFile basename ]);
		              run.
	^ chosenName ifNotNil: [ imageFiles detect: [ :imageFile | imageFile basename = chosenName ] ]
]

{ #category : 'ui interaction' }
PhLImportImageCommand >> chooseNewImageNameFor: anImageName [
	^ self imagesPresenter newRequest
		title: 'An image with the name ', anImageName , ' already exists. Please choose a new name:';
		initialAnswer: (self imagesPresenter imageRepository makeUniqueImageName: anImageName);
		validateAnswer: [ :answer | (self imagesPresenter imageRepository hasImageNamed: answer) not ];
		request
]

{ #category : 'executing' }
PhLImportImageCommand >> execute [

	importSiblings := self askToImportSiblings ifNil: [ ^ self ].
	self importImage
]

{ #category : 'executing' }
PhLImportImageCommand >> import: imageFileRef [

	| infoMessage destFolderName imageRepository |
	destFolderName := imageFileRef basenameWithoutExtension.
	imageRepository := self imagesPresenter imageRepository.
	[ imageRepository ensureNoImageWithName: destFolderName ]
		on: PhLNameNotAvailableError
		do: [ destFolderName := self chooseNewImageNameFor: destFolderName ].
	destFolderName ifNil: [ ^ self "abort" ].

	importSiblings
		ifTrue: [ imageRepository importImageNamed: imageFileRef andSiblingFilesto: destFolderName ]
		ifFalse: [ imageRepository importImage: imageFileRef to: destFolderName ].
	self imagesPresenter selectImage: (imageRepository imageNamed: destFolderName asLowercase).
	infoMessage := 'Image ' , imageFileRef fullName , ' imported!'.
	self imagesPresenter newInformation
		title: 'Import';
		message: (infoMessage withNoLineLongerThan: 60);
		inform
]

{ #category : 'executing' }
PhLImportImageCommand >> importFromFolder: aDirectory [

	| imageFiles imageFile |
	imageFiles := self class imageFilesIn: aDirectory.
	imageFiles ifEmpty: [
			self imagesPresenter newInformation
				title: 'Import';
				message: 'No Pharo image found in ' , aDirectory basename , '.';
				inform.
			^ self ].
	imageFile := imageFiles size = 1
		             ifTrue: [ imageFiles first ]
		             ifFalse: [ self chooseImageAmong: imageFiles asArray ].
	imageFile ifNil: [ ^ self ].
	importSiblings := self askToImportSiblings ifNil: [ ^ self ].
	self import: imageFile
]

{ #category : 'executing' }
PhLImportImageCommand >> importImage [
	| imageFile |
	imageFile := self imagesPresenter newFileRequest
		title: 'Import a Pharo image (will move image, changes file and pharo-local folder)';
		filter: '.image';
		currentFolder: FileLocator home;
		chooseFile.
	imageFile ifNil: [ 
		self imagesPresenter newInformation
			title: 'Import';
			message: 'No path selected. Import failed.';
			inform.
		^ self ].
	imageFile asFileReference isDirectory ifTrue: [ 
		self imagesPresenter newInformation 
			title: 'Import';
			message: 'The file selected is a directory and not a Pharo image. Import failed.';
			inform.
		^ self ].
	self import: imageFile
]

{ #category : 'initialization' }
PhLImportImageCommand >> initialize [
	super initialize.
	self
		name: 'Import';
		description:
			'Import into Pharo Launcher an existing Pharo image (and possibly its parent folder)'
]
