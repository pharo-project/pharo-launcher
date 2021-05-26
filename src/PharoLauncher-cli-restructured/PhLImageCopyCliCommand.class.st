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
	#instVars : [
		'repository',
		'stream'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageCopyCliCommand class >> asCliCommand [
	^ self asCliCommand: PharoLauncherCLIModel new.
]

{ #category : #'command line' }
PhLImageCopyCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #copy launcherModel:aPharoLauncherModel 
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
PhLImageCopyCliCommand >> copyName [ 
  ^arguments words at: 3.
]

{ #category : #'command execution' }
PhLImageCopyCliCommand >> execute:aPharoLauncherCLIModel [
   | arg1 arg2 |
   arg1 := self imageName.
   arg2 := self copyName.
   self outputCopyImage: arg1 to: arg2 dir:aPharoLauncherCLIModel.
   

   
]

{ #category : #'as yet unclassified' }
PhLImageCopyCliCommand >> findImage: anImageName dir: someDirectory [
   |  theImage |
   theImage := someDirectory imageBaseRepository images detect: [ :anImage | anImage name = anImageName ]. 
   ^theImage 
]

{ #category : #accessing }
PhLImageCopyCliCommand >> imageName [ 
  ^arguments words at: 2.
]

{ #category : #'command execution' }
PhLImageCopyCliCommand >> initialize [

	stream := VTermOutputDriver stdout.

]

{ #category : #accessing }
PhLImageCopyCliCommand >> outputCopyImage: imageName to: newImageName dir: aPharoLauncherCLIModel [ 

	| anImage |
	[ anImage := self findImage: imageName dir:aPharoLauncherCLIModel ]
		on: NotFound
		do: [ :c | 
			stream nextPutAll: 'please enter a correct local image'.
			stream cr.
			^ self ].
	aPharoLauncherCLIModel imageBaseRepository copyImage: anImage to: newImageName
]

{ #category : #'command execution' }
PhLImageCopyCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
   
   
]
