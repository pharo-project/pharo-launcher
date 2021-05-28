"
I represent Pharo Image copy sub-command invoked from cmd line of Pharo Launcher. My responsibility is to copy images within Pharo launcher. 

I declare: 
- mandatory positional with existing image name to be copied
- flag for specifying new image name (other than default)

I execute:
- copy the existing image based on specified name to new image with new name
"
Class {
	#name : #PhLImageCopyCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageCopyCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #copy launcherModel: aPharoLauncherModel
]

{ #category : #'command line' }
PhLImageCopyCliCommand class >> launcherCmdDescription [

	^ 'Creates copy of given image with new name.'
]

{ #category : #'command line - arguments' }
PhLImageCopyCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #newImageName)
				description: 'Name of new image created from copy of existing.';
				add: ((ClapPositional id: #newName)
					description: 'New image name.';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [ :arg :app | app defaultLanguage ])}
]

{ #category : #'command line - arguments' }
PhLImageCopyCliCommand class >> launcherCmdPositionals [

	^ {((ClapPositional id: #existingImageName)
				description: 'Local image name to be copied.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app | app  ];
					yourself).
		((ClapPositional id: #newImageName)
				description: 'New image name of a copied image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app | app  ];
					yourself)	
	}
]

{ #category : #accessing }
PhLImageCopyCliCommand >> copyImage: imageName to: newImageName [ 

	| anImage |
	[ anImage := self findImage: imageName ]
		on: NotFound
		do: [ :c | 
			outStream nextPutAll: 'please enter a correct local image'.
			outStream cr.
			^ self ].
	self pharoLauncherModel imageBaseRepository copyImage: anImage to: newImageName
]

{ #category : #'command execution' }
PhLImageCopyCliCommand >> execute [

   self copyImage: self imageName to: self targetName 
   

   
]

{ #category : #'as yet unclassified' }
PhLImageCopyCliCommand >> findImage: anImageName [
	| theImage |
	theImage := self pharoLauncherModel imageBaseRepository images
		detect: [ :anImage | anImage name = anImageName ].
	^ theImage
]

{ #category : #accessing }
PhLImageCopyCliCommand >> imageName [ 
  ^ (arguments at: #existingImageName) word
]

{ #category : #accessing }
PhLImageCopyCliCommand >> targetName [ 
  ^ (arguments at: #newImageName) word


]
