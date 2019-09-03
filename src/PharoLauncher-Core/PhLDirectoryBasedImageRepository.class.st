"
I'm a group of images which are stored in subdirectories of a dedicated directory.

Each image in the group is stored in its own subdirectory with the same name as the image. E.g., if the group's baseDirectory is ~/.config/pharo/images, one example of an image could be ~/.config/pharo/images/Seaside3.0/Seaside3.0.image.

Instance Variables
	baseDirectory:		place where the images are stored
	images:		collection of PhImage

"
Class {
	#name : #PhLDirectoryBasedImageRepository,
	#superclass : #PhLRepository,
	#instVars : [
		'baseDirectory'
	],
	#classVars : [
		'Default',
		'Location'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLDirectoryBasedImageRepository class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #defaults }
PhLDirectoryBasedImageRepository class >> defaultLocation [
	^ PlatformResolver forCurrentPlatform launcherUserFilesLocation / 'images' 
]

{ #category : #'instance creation' }
PhLDirectoryBasedImageRepository class >> forDirectory: aDirectory [
	^ self new
		setBaseDirectory: aDirectory;
		yourself
]

{ #category : #'class initialization' }
PhLDirectoryBasedImageRepository class >> initialize [

	PhLStartupManager addToLauncherStartUpList: self
]

{ #category : #'system startup' }
PhLDirectoryBasedImageRepository class >> launcherStartUp [
	"Fix the Location because the platform or computer can have changed"

	(Location notNil and: [ Location exists not ])
		ifTrue: [ 
			"We could probably always set to nil without the previous checks, but I'm not sure because it may depend on #startUp order of classes (e.g., if PhLSettingBrowser class>>#startUp is first, we may have a problem)."
			Location := nil ]
]

{ #category : #'system startup' }
PhLDirectoryBasedImageRepository class >> launcherStartUpPriority [
	^ 1
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository class >> location [
	^ Location ifNil: [ Location := self defaultLocation ]
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository class >> location: directory [
	self location asFileReference = directory
		ifFalse: [ 
			self migrateFrom: self location to: directory.
			Location := directory.
			self default contentsChanged ]
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository class >> locationString [
	^ self location pathString 
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository class >> locationString: aDirectoryString [
	^ self location: aDirectoryString asFileReference
]

{ #category : #private }
PhLDirectoryBasedImageRepository class >> migrateFrom: oldLocation to: newLocation [
	(oldLocation exists and: [ (self forDirectory: oldLocation) hasImages ])
		ifTrue: [ 
			| command |
			command := PhLRelocateImageDirectoryCommand new
				source: oldLocation;
				target: newLocation;
				executeOrInform ]
]

{ #category : #settings }
PhLDirectoryBasedImageRepository class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #locationString)
		label: 'Location of your images' translated;
		type: #Directory;
		parent: #pharoLauncher;
		target: self;
		order: 40;
		description: 'A directory where all your Pharo images will be saved and launched'
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository >> baseDirectory [
	^ (baseDirectory ifNil: [ self class location ]) ensureCreateDirectory
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> copyImage: anImage to: aString [
	self copyImageNamed: anImage name to: aString
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> copyImageNamed: sourceName to: targetName [
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: targetName.
	targetDirectory := self prepareForNewImageNamed: targetName.
	sourceDirectory := self directoryForImageNamed: sourceName.
	CopyVisitor copy: sourceDirectory to: targetDirectory.
	self renameImageInFolder: targetDirectory to: targetName.
	self contentsChanged
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> deleteImage: anImage [
	self deleteImageNamed: anImage name
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> deleteImageNamed: aString [
	(self directoryForImageNamed: aString) deleteAll.
	self contentsChanged.
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> deleteImages: someImages [
	self dontNotifyDuring: [ someImages do: [ :image | self deleteImage: image ] ].
	self contentsChanged
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository >> directoryForImageNamed: aString [
	^ self baseDirectory / aString
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> ensureNoImageWithName: anImageName [
	(self hasImageNamed: anImageName)
		ifTrue: [ PhLError signal: 'An image with the same name already exists' ]
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> extractTemplate: aTemplate to: anImageName [
	| destination |
	self ensureNoImageWithName: anImageName.
	destination := self prepareForNewImageNamed: anImageName.
	aTemplate extractTo: destination named: anImageName.
	self contentsChanged.
]

{ #category : #testing }
PhLDirectoryBasedImageRepository >> hasImageNamed: aString [ 
	^ self includesImageNamedCaseInsensitive: aString
]

{ #category : #testing }
PhLDirectoryBasedImageRepository >> hasImages [
	^ self images notEmpty
]

{ #category : #private }
PhLDirectoryBasedImageRepository >> imageFromDirectory: aDirectory [
	"Create an instance of PhLImage representing the Pharo image in aDirectory"

	| imageName imageFiles changeFiles |
	imageName := aDirectory basename.
	imageFiles := aDirectory filesMatching: imageName , '.image'.
	changeFiles := aDirectory filesMatching: imageName , '.changes'.
	^ (imageFiles size ~= 1 or: [ changeFiles size ~= 1 ])
		ifTrue: [ nil ]
		ifFalse: [ PhLImage location: imageFiles first ]
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository >> imageNames [
	^ self images collect: #name
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository >> images [
	| images |
	images := OrderedCollection new.
	self baseDirectory directories
		do: [ :directory | (self imageFromDirectory: directory) ifNotNil: [ :image | images add: image ] ].
	^ images
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> importImageNamed: imagePath andSiblingFilesto: targetName [
	| sourceDirectory |
	imagePath asFileReference exists ifFalse: [ ^ self ].
	
	sourceDirectory := imagePath asFileReference parent.
	self moveImage: sourceDirectory to: targetName
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> importImageNamed: sourceName to: targetName [
	| sourceDirectory targetDirectory imageLocalDirectory |
	self ensureNoImageWithName: targetName.
	sourceDirectory := sourceName asFileReference parent.
	targetDirectory := self prepareForNewImageNamed: targetName.
	{ sourceName asFileReference . sourceName asFileReference withoutExtension , 'changes' }
		do: [ :file | 
			| targetFilename |
			targetFilename := self newNameForFile: file whenRelocatingToImageNamed: targetName.
			file moveTo: targetDirectory / targetFilename ].
	imageLocalDirectory := (sourceDirectory / SystemResolver defaultLocalDirectoryName).
	imageLocalDirectory exists 
		ifTrue: [ imageLocalDirectory moveTo: targetDirectory / imageLocalDirectory basename ].
	sourceDirectory hasChildren 
		ifFalse: [ sourceDirectory delete ].
	self contentsChanged.
]

{ #category : #testing }
PhLDirectoryBasedImageRepository >> includesImageNamedCaseInsensitive: anImageName [
	"Windows OS doesnt care about case for folder names."
	| lowercaseImageName |
	lowercaseImageName := anImageName asLowercase.
	^ self images anySatisfy: [ :image | image name asLowercase = lowercaseImageName ]
]

{ #category : #testing }
PhLDirectoryBasedImageRepository >> isNewImageNameValid: aString [ 
	^ aString isEmptyOrNil not and: [ (self hasImageNamed: aString) not ]
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> makeUniqueImageName: baseImageName [
	^ self makeUniqueImageName: baseImageName among: self imageNames.
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> makeUniqueImageName: baseImageName among: existingImageNames [
	"Provide a reasonable default image name using the next incremental count for images with similar basenames"

	"See #testMakeUniqueImageName for samples"

	^ self makeUniqueName: baseImageName among: existingImageNames
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> moveImage: sourceDirectory to: newName [
	| targetDirectory |
	self ensureNoImageWithName: newName.
	targetDirectory := self directoryForImageNamed: newName.	"Do not create a new directory to ensure that the moveTo will succeed"
	sourceDirectory moveTo: targetDirectory.
	self renameImageInFolder: targetDirectory to: newName.
	self contentsChanged
]

{ #category : #private }
PhLDirectoryBasedImageRepository >> newNameForFile: file whenRelocatingToImageNamed: targetName [
	"Return the name that should be given to file when the file is going to be moved or copied to the image targetName. The file name is kept intact unless it must reflect the image name."
	^ (#('image' 'changes') includes: file extension)
		ifTrue: [ targetName , '.' , file extension ]
		ifFalse: [ file basename ]
]

{ #category : #private }
PhLDirectoryBasedImageRepository >> prepareForNewImageNamed: aString [
	^ (self directoryForImageNamed: aString) ensureCreateDirectory
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> recreateImage: anImage [
	anImage originTemplate 
		ifNil: [ PhLCommandError signal ].
		
	self 
		deleteImage: anImage; 
		extractTemplate: anImage originTemplate to: anImage name.

]

{ #category : #action }
PhLDirectoryBasedImageRepository >> renameImage: anImage to: newName [
	self renameImageNamed: anImage name to: newName
]

{ #category : #private }
PhLDirectoryBasedImageRepository >> renameImageInFolder: targetDirectory to: newName [
	targetDirectory children
		do: [ :file | 
			| targetFilename |
			targetFilename := self
				newNameForFile: file
				whenRelocatingToImageNamed: newName.
			file basename = targetFilename
				ifFalse: [ file renameTo: targetFilename ] ]
]

{ #category : #action }
PhLDirectoryBasedImageRepository >> renameImageNamed: oldName to: newName [
	| sourceDirectory |
	(self isNewImageNameValid: newName)
		ifFalse: [ PhLCommandError signal ].
	sourceDirectory := self directoryForImageNamed: oldName.
	self moveImage: sourceDirectory to: newName 
]

{ #category : #accessing }
PhLDirectoryBasedImageRepository >> roots [
	^ self images sorted: [ :image1 :image2 | image1 name asUppercase < image2 name asUppercase ]
]

{ #category : #'initialize-release' }
PhLDirectoryBasedImageRepository >> setBaseDirectory: aLocation [
	baseDirectory := aLocation
]
