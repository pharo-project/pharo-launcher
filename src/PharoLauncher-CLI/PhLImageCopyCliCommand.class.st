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
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageCopyCliCommand class >> addLauncherPositionalsTo: aCommandSpec [
	
	(aCommandSpec 
		addPositional: #existingImageName 
		description: 'Local image name to be copied.')
	implicitMeaning: [:arg :app | self raiseImageToCopyNotFound].

	(aCommandSpec 
		addPositional: #newImageName 
		description: 'New image name of a copied image.')
	implicitMeaning: [:arg :app | self raiseNewImageNotFound].
	"
	^ {((ClapPositional id: #existingImageName)
				description: 'Local image name to be copied.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'Image to copy argument is missing.' . ];
					yourself).
		((ClapPositional id: #newImageName)
				description: 'New image name of a copied image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'New image name argument is missing.' .   ];
					yourself)	
	}"
]

{ #category : #'command line' }
PhLImageCopyCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #copy
]

{ #category : #'command line' }
PhLImageCopyCliCommand class >> launcherCmdDescription [

	^ 'Creates copy of given image with new name.'
]

{ #category : #'error signalling' }
PhLImageCopyCliCommand class >> raiseImageToCopyNotFound [

	^ NotFound signal: 'Image to copy argument is missing'
]

{ #category : #'error signalling' }
PhLImageCopyCliCommand class >> raiseNewImageAlreadyUsed: targetName [

	^ PhLNameNotAvailableError signal: ('Target image name ''{1}'' already used.' format: { targetName  })
]

{ #category : #'error signalling' }
PhLImageCopyCliCommand class >> raiseNewImageNotFound [

	^ NotFound signal: 'New image name argument is missing.'
]

{ #category : #'command execution' }
PhLImageCopyCliCommand >> executeWithImage: anImage [

	[ self imageRepository copyImage: anImage to: self targetName ]
		on: PhLNameNotAvailableError
		do: [ ^ self class raiseNewImageAlreadyUsed: self targetName ]
]

{ #category : #accessing }
PhLImageCopyCliCommand >> targetName [

	^ self positional: #newImageName
]
