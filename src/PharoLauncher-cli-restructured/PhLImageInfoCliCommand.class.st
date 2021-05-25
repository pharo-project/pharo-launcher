"
I represent Pharo Image info sub-command invoked from cmd line of Pharo Launcher. My responsibility is to print info about local image within Pharo launcher based on specified image name. 

I declare: 
- mandatory positional with existing image  name, based on which is output with info about image printed
- optional flag for specifying stonOutput to print result into ston format/file

I execute:
- create new local image based on specified image template name with new name specified as flag
"
Class {
	#name : #PhLImageInfoCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageInfoCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #info
]

{ #category : #'command line' }
PhLImageInfoCliCommand class >> launcherCmdDescription [

	^ 'Prints information about image: name, description, origin template, etc.'
]

{ #category : #'command line - arguments' }
PhLImageInfoCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Local image name from which we display the informations.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #accessing }
PhLImageInfoCliCommand >> execute [
   | arg1 |
    
   arg1 := self imageName.
   self outputImageInfo: arg1.
]

{ #category : #accessing }
PhLImageInfoCliCommand >> findImage: anImageName [
   |  theImage |
   theImage := repository images detect: [ :anImage | anImage name = anImageName ]. 
   ^theImage 
]

{ #category : #accessing }
PhLImageInfoCliCommand >> imageName [ 
  ^arguments words at: 2.
]

{ #category : #accessing }
PhLImageInfoCliCommand >> initialize [

	stream := VTermOutputDriver stdout.
	repository := PhLDirectoryBasedImageRepository default.
]

{ #category : #accessing }
PhLImageInfoCliCommand >> outputImageInfo: anImageName [
	| imageOriginTemplate imageName imageDescription imagePharoVersion lastModified imageOriginTemplateURL imageDirectory anImage |
	anImage := PhLImagesClapCommand new.
	[ anImage := anImage findImage: anImageName ]
		on: Error , NotFound
		do: [ :c | 
			stream nextPutAll: 'please enter a correct local image'.
			stream cr.
			^ 0 ].
	imageOriginTemplate := anImage originTemplateName.
	imageName := anImage name.
	lastModified := anImage lastModification.
	imageOriginTemplateURL := anImage originTemplateUrl.
	imageDirectory := anImage location.
	imageDescription := anImage description.
	imagePharoVersion := anImage pharoVersionFromFile.
	stream
		nextPutAll: 'image name: ';
		nextPutAll: imageName asString;
		cr;
		nextPutAll: ' image description: ';
		nextPutAll: imageDescription asString;
		cr;
		nextPutAll: ' image version: ';
		nextPutAll: imagePharoVersion asString;
		cr;
		nextPutAll: ' image origin template: ';
		nextPutAll: imageOriginTemplate asString;
		cr;
		nextPutAll: ' image template URL: ';
		nextPutAll: imageOriginTemplateURL asString;
		cr;
		nextPutAll: ' image path: ';
		nextPutAll: imageDirectory asString;
		cr;
		nextPutAll: ' image last modification ';
		nextPutAll: lastModified asString;
		cr
]

{ #category : #accessing }
PhLImageInfoCliCommand >> repository: aPhLMockImageRepository [ 
	repository := aPhLMockImageRepository
]

{ #category : #accessing }
PhLImageInfoCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
