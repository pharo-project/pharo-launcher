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
	#category : #'PharoLauncher-CLI-Commands'
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
PhLImageInfoCliCommand class >> launcherCmdFlags [
	^ {
		"add printing flags"
		self briefFlag.
		self rowModeFlag.
		self delimiterFlag.
		self stonFlag 
			description: 'Prints information of specified image using STON format. ';
			yourself.
			}
]

{ #category : #'command line - arguments' }
PhLImageInfoCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Determines the local image name to print detailed information.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app |NotFound 
        signal: 'An argument is missing, please specify the image name to print information.'];
		yourself)}
]

{ #category : #accessing }
PhLImageInfoCliCommand >> executeWithImage: anImage [ 

   self list: (Array with: anImage)
]

{ #category : #'private ' }
PhLImageInfoCliCommand >> listPrintAttributeBlocks [

	^ self filterPrintAttributesFrom: self modelClass extendedListPrintAttributeBlocks
]

{ #category : #'private ' }
PhLImageInfoCliCommand >> listPrintAttributeLabels [

	^ self filterPrintAttributesFrom: self modelClass extendedListPrintAttributeLabels
]

{ #category : #accessing }
PhLImageInfoCliCommand >> printSequence [

	"do not print sequence number for one image"
	^ false
]

{ #category : #accessing }
PhLImageInfoCliCommand >> rowMode [

	"image info is printed in one attribute per row"
	^ true
]
