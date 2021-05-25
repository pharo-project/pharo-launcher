"
I represent Pharo Image launch sub-command invoked from cmd line of Pharo Launcher. My responsibility is to launch local image with auto-detected VM within Pharo launcher based on specified image name. 

I declare: 
- mandatory positional with existing image name, based on which is image launched

I execute:
- launch local image with auto-detected VM
"
Class {
	#name : #PhLImageLaunchCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #launch
]

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> launcherCmdDescription [

	^ 'Lauches image with using default (auto-detected) VM.'
]

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Local image name which will be launched.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> execute [
   | arg1 |
    
   arg1 := self imageName.
   self outputImageLaunch: arg1.
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> findImage: anImageName [
   |  theImage |
   theImage := repository images detect: [ :anImage | anImage name = anImageName ]. 
   ^theImage 
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> imageName [ 
  ^arguments words at: 2.
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> initialize [

	stream := VTermOutputDriver stdout.
	repository := PhLDirectoryBasedImageRepository default.
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> outputImageLaunch: anImageName2 [
	| anImage |
	[ anImage := self findImage: anImageName2 ]
		on: NotFound
		do: [ :c | 
			stream nextPutAll: 'please enter a correct local image'.
			stream cr.
			^ 0 ].
	anImage ensureDefaultConfiguration.
	anImage launch
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> repository: aPhLMockImageRepository [ 
	repository := aPhLMockImageRepository
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
