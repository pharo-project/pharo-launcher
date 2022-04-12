"
I represent Pharo Image list sub-command invoked from cmd line of Pharo Launcher. My responsibility is to list local images within Pharo launcher that were previously created or imported. 

I declare: 
- optional flag for stonOutput

I execute:
- list local images with detailed information about image name, used VM, architecture, local dir, etc.
"
Class {
	#name : #PhLImageListCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #list 
]

{ #category : #'command line' }
PhLImageListCliCommand class >> launcherCmdDescription [

	^ 'Lists all local images from Pharo laucher repository.'
]

{ #category : #'command line - arguments' }
PhLImageListCliCommand class >> launcherCmdFlags [
	^ Array 
		with: ((ClapFlag id: #name)
			description: 'Determines the name of image (or its substring) to list local images.';
			meaning: [ :arg :app | "this argument is optional "
				(arg at: #nameAsString) word ];
			implicitMeaning: [ :arg :app |  ];
			add: ((ClapPositional id: #nameAsString)
					description: 'A substring to search from the list of local Pharo images.';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [ :arg :app | ]);
			yourself)
		withAll: self printFlags
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> execute [
	^ self listImages
]

{ #category : #listing }
PhLImageListCliCommand >> imagesFromName: aSubtring [
	| imagesIncludingSubstring |
	imagesIncludingSubstring := self imageRepository images
		select: [ :anImage | anImage name includesSubstring: aSubtring ].
	^ imagesIncludingSubstring
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> listImages [
	| images |
	images := self name 
		ifNil: [  self imageRepository images ]
		ifNotNil:[ self imagesFromName: self name ].

	self list: images
]

{ #category : #'accessing arguments' }
PhLImageListCliCommand >> name [
	^ (arguments at: #name) value: self
]
