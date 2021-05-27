"
I represent Pharo Image delete sub-command invoked from cmd line of Pharo Launcher. My responsibility is to delete local images within Pharo launcher based on specified image name. 

I declare: 
- mandatory positional with existing image name, based on which is image deleted

I execute:
- delete local image based on specified image name
"
Class {
	#name : #PhLImageDeleteCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #delete launcherModel: aPharoLauncherModel
]

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> launcherCmdDescription [

	^ 'Deletes image from computer, including local image directory content.'
]

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Local image name to be deleted.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> execute [
   | arg1 |
    
   arg1 := self imageName.
   self outputDeleteImage: arg1.
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> findImage: anImageName [
	| theImage |
	theImage := repository images
		detect: [ :anImage | anImage name = anImageName ].
	^ theImage
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> imageName [ 
  ^arguments words at: 2.
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> initialize [

	stream := VTermOutputDriver stdout.
	repository := PhLDirectoryBasedImageRepository default.
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> outputDeleteImage: imageName [

	| anImage |
	
	[ anImage := self findImage: imageName ]
		on: Error , NotFound
		do: [ :c | 
			stream nextPutAll: 'please enter a correct local image'.
			stream cr.
			^ 0 ].

	repository deleteImage: anImage
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> repository: aPhLMockImageRepository [ 
	repository := aPhLMockImageRepository
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
