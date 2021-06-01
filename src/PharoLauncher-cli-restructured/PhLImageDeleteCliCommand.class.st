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
PhLImageDeleteCliCommand >> deleteImage: imageName [

	| anImage |
	
	[ anImage := self findImage: imageName ]
		on: Error , NotFound
		do: [ :c | 
			self outStream nextPutAll: 'please enter a correct local image'.
			self outStream cr.
			^ self ].

	self pharoLauncherModel imageBaseRepository deleteImage: anImage
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> execute [
   self deleteImage: self imageName
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> imageName [ 
  ^ (arguments at: #existingImageName) word
]
