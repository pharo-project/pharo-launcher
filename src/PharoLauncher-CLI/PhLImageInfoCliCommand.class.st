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

{ #category : #'command line - arguments' }
PhLImageInfoCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	self addPrintFlagsTo: aCommandSpec
]

{ #category : #'command line - arguments' }
PhLImageInfoCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #existingImageName 
		description: 'Determines the local image name to print detailed information.')
	implicitMeaning: [ :arg :app | self raiseMissingImageToPrintDetails]
]

{ #category : #'command line' }
PhLImageInfoCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #info 
]

{ #category : #'command line' }
PhLImageInfoCliCommand class >> launcherCmdDescription [

	^ 'Prints information about image: name, description, origin template, etc.'
]

{ #category : #'error signalling' }
PhLImageInfoCliCommand class >> raiseMissingImageToPrintDetails [

	^ NotFound signal: 'An argument is missing, please specify the image name to print information.'
]

{ #category : #'command execution' }
PhLImageInfoCliCommand >> basicExecute [ 

	self list: (Array with: self selectedImage)
]

{ #category : #'private ' }
PhLImageInfoCliCommand >> listPrintAttributeBlocks [

	^ self filterPrintAttributesFrom: self modelClass extendedListPrintAttributeBlocks
]

{ #category : #'private ' }
PhLImageInfoCliCommand >> listPrintAttributeLabels [

	^ self filterPrintAttributesFrom: self modelClass extendedListPrintAttributeLabels
]

{ #category : #'accessing arguments' }
PhLImageInfoCliCommand >> printSequence [

	"do not print sequence number for one image"
	^ false
]

{ #category : #'accessing arguments' }
PhLImageInfoCliCommand >> rowMode [

	"image info is printed in one attribute per row"
	^ true
]
