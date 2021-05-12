"
New attemp to manage command lines for the launcher.
"
Class {
	#name : #PhLImagesClapCommand,
	#superclass : #Object,
	#instVars : [
		'stream',
		'repository',
		'anImageName'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> copy [ 
	^(ClapCommand withName: 'copy')
		description: 'Creates copy of given image with new name.';
		add: ClapFlag forHelp;
		meaning: [ :args | | anImage |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			anImage := args parent parent parent arguments at:3.
         self outputCopyImage: anImage.  
		 ]
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> create [
	^(ClapCommand withName: 'create')
		description: 'Downloads and creates new images on the system from remote website based on template name';
		add: ClapFlag forHelp;
		meaning: [ :args | | anImage |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			anImage := args parent parent parent arguments at:3.
         self outputCreateImage: anImage.  
		 ]
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> delete [
	^(ClapCommand withName: 'delete')
		description: 'Delete image on the local computer.';
		add: ClapFlag forHelp;
		meaning: [ :args | | anImage |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			anImage := args parent parent parent arguments at:3.
         self outputDeleteImage: anImage.  
		 ]
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> imagesCommands [
	<commandline>
	^(ClapCommand withName: 'images')
	 description: 'for images';
	 add: (self list);
	 add: (self info);
	 add: (self launch);
	 add: (self create);
	 add: (self copy);
	 add: (self delete);
	 add: (self initScriptsDir).
	 
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> info [
	^(ClapCommand withName: 'info')
		description: 'Prints information about image: name, description, origin template, etc.';
		add: ClapFlag forHelp;
		meaning: [ :args | | anImage |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			anImage := args parent parent parent arguments at:3.
         self outputImageInfo: anImage.  
		 ]
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> initScriptsDir [
	^(ClapCommand withName: 'iniScriptsDir')
		description: 'sets directory path, where init scripts for images are located';
		add: ClapFlag forHelp;
		meaning: [ :args | | aDirectoryPath |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			aDirectoryPath := args parent parent parent arguments at:3.
         self outputInitScriptsDir: aDirectoryPath.  
		 ]
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> launch [
	^(ClapCommand withName: 'launch')
		description: 'Launches image with using default VM';
		add: ClapFlag forHelp;
		meaning: [ :args | | anImage |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			anImage := args parent parent parent arguments at:3.
         self outputImageLaunch: anImage.  
		 ]
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> list [
	^(ClapCommand withName: 'list')
		description: 'Lists all downloaded images on local computer.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				self outputListImagesAsSton. 
				ston exitSuccess ].
         self outputListImages
		 ].
	
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> outputCopyImage: anImage [ 
  self new outputCopyImage: anImage. 
  
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> outputCreateImage: anImage [
  self new outputCreateImage: anImage. 
  
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> outputDeleteImage: anImage [ 
  self new outputDeleteImage: anImage. 
  
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> outputImageInfo: anImage [ 
  self new outputImageInfo: anImage. 
  
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> outputImageLaunch: anImage [ 
  self new outputImageLaunch: anImage. 
  
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand class >> outputInitScriptsDir: aDirectoryPath [ 
  self new outputInitScriptsDir: aDirectoryPath . 
  
]

{ #category : #'instance creation' }
PhLImagesClapCommand class >> outputListImages [
	self new outputListImages
]

{ #category : #'instance creation' }
PhLImagesClapCommand class >> outputListImagesAsSton [
	self new outputListImagesAsSton
]

{ #category : #'as yet unclassified' }
PhLImagesClapCommand >> findImage: anImageName [
   |  theImage |
   theImage := repository images detect: [ :anImage | anImage name = anImageName ]. 
   ^theImage 
]

{ #category : #initialization }
PhLImagesClapCommand >> initialize [

	stream := VTermOutputDriver stdout.
	repository := PhLDirectoryBasedImageRepository default.
]

{ #category : #accessing }
PhLImagesClapCommand >> outputCopyImage: imageName [
   | anImage imageCopy |
   anImage := PhLImagesClapCommand new.
   [anImage := anImage findImage: imageName]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct local image'.stream cr.^0].
   imageCopy  := PhLDirectoryBasedImageRepository new.
   imageCopy copyImage: anImage to: 'sdkhbdfskd'
   
   
   
  
]

{ #category : #accessing }
PhLImagesClapCommand >> outputCreateImage: aTemplateName [
   | listTemplatesAvailableForDownload templateToDownload|
   listTemplatesAvailableForDownload := PhLTemplateGroupRepository default roots. 
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload  detect: [:aGroup | aGroup name = 'Official distributions'  ].
   templateToDownload := listTemplatesAvailableForDownload children detect: [ :aTemplate | aTemplate name = aTemplateName ].
   
    PhLDirectoryBasedImageRepository default extractTemplate: templateToDownload to: '<papapa>'


]

{ #category : #accessing }
PhLImagesClapCommand >> outputDeleteImage: imageName [
   | anImage deleteMachine|
   anImage := PhLImagesClapCommand new.
   [anImage := anImage findImage: imageName]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct local image'.stream cr.^0].
   deleteMachine := PhLDirectoryBasedImageRepository new.
   deleteMachine deleteImage: anImage.

    
   
   
   
   
  
]

{ #category : #accessing }
PhLImagesClapCommand >> outputImageInfo: anImageName [
   | imageOriginTemplate imageName imageDescription imagePharoVersion lastModified imageOriginTemplateURL imageDirectory anImage |
   anImage := PhLImagesClapCommand new.
   [anImage := anImage findImage: anImageName]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct local image'.stream cr.^0].
   imageOriginTemplate := anImage originTemplateName.
   imageName := anImage name.
   lastModified := anImage lastModification.
   imageOriginTemplateURL := anImage originTemplateUrl.
   imageDirectory := anImage location.
   imageDescription := anImage description. 
   imagePharoVersion := anImage pharoVersionFromFile.
   stream nextPutAll: 'image name: ';
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
          cr.
]

{ #category : #accessing }
PhLImagesClapCommand >> outputImageLaunch: anImageName [
   | anImage |
   anImage := PhLImagesClapCommand new.
   [anImage := anImage findImage: anImageName]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct local image'.stream cr.^0].
   anImage ensureDefaultConfiguration.
anImage launch.
   
   
]

{ #category : #accessing }
PhLImagesClapCommand >> outputInitScriptsDir: aDirectoryName [
]

{ #category : #'instance creation' }
PhLImagesClapCommand >> outputListImages [

	repository images
		do: [ :anImage | stream nextPutAll: anImage name. stream lf. ]
]

{ #category : #'instance creation' }
PhLImagesClapCommand >> outputListImagesAsSton [

	stream nextPutAll: (STON toString: (repository images collect: [:each | each file ]))
]

{ #category : #accessing }
PhLImagesClapCommand >> repository: aPhLMockImageRepository [ 
	repository := aPhLMockImageRepository
]

{ #category : #accessing }
PhLImagesClapCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
