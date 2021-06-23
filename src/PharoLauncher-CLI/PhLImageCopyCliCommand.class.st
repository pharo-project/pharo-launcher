"
I represent Pharo Image copy sub-command invoked from cmd line of Pharo Launcher. My responsibility is to copy images within Pharo launcher. 

I declare: 
- mandatory positional with existing image name to be copied
- flag for specifying new image name (other than default)

I execute:
- copy the existing image based on specified name to new image with new name

Utilisation:
Example of utilisation with imageToCopy and copiedImageName:
./pharo -path/to/the/image/with/PharoLauncherCLI clap launcher image copy imageToCopy copiedImageName
"
Class {
	#name : #PhLImageCopyCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageCopyCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #copy
]

{ #category : #'command line' }
PhLImageCopyCliCommand class >> launcherCmdDescription [

	^ 'Creates copy of given image with new name.'
]

{ #category : #'command line - arguments' }
PhLImageCopyCliCommand class >> launcherCmdPositionals [

	^ {((ClapPositional id: #existingImageName)
				description: 'Local image name to be copied.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'image to copy argument is missing' . ];
					yourself).
		((ClapPositional id: #newImageName)
				description: 'New image name of a copied image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'new image name argument is missing' .   ];
					yourself)	
	}
]

{ #category : #'command execution' }
PhLImageCopyCliCommand >> executeWithImage: anImage [
	[ self imageRepository copyImage: anImage to: self targetName ]
		on: PhLNameNotAvailableError
		do: [ ^ self errorStream
				nextPutAll: 'Name already used';
				newLine ]
]

{ #category : #accessing }
PhLImageCopyCliCommand >> targetName [
	^ (arguments at: #newImageName) word
]
