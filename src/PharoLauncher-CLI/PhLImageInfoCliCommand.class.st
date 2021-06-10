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
	#category : #'PharoLauncher-CLI'
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
PhLImageInfoCliCommand >> executeWithImage: anImage [ 
   self printInformation: anImage
]

{ #category : #printing }
PhLImageInfoCliCommand >> printInformation: anImage [ 
	self outStream
		nextPutAll: 'image name: ';
		nextPutAll: anImage name asString;
		cr;
		nextPutAll: ' image description: ';
		nextPutAll: anImage description asString;
		cr;
		nextPutAll: ' image version: ';
		nextPutAll: anImage pharoVersionFromFile asString;
		cr;
		nextPutAll: ' image origin template: ';
		nextPutAll: anImage originTemplateUrl asString;
		cr;
		nextPutAll: ' image template URL: ';
		nextPutAll:  anImage originTemplateName asString;
		cr;
		nextPutAll: ' image path: ';
		nextPutAll: anImage location asString;
		cr;
		nextPutAll: ' image last modification ';
		nextPutAll: anImage lastModification asString;
		cr
]
