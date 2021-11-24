"
Command to kill one image if given in option or all the images if the --all flag is set 
"
Class {
	#name : #PhLImageKillCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'allFlag'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageKillCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #kill 
]

{ #category : #'command line' }
PhLImageKillCliCommand class >> launcherCmdDescription [

	^ 'kill the given image or all if the flag --all is given'
]

{ #category : #'command line - arguments' }
PhLImageKillCliCommand class >> launcherCmdFlags [
	^ {((ClapFlag id: #all)
		description: 'kill all the running pharo images ';
		meaning: [ :arg :app | true ];
		implicitMeaning: [ :arg :app | false ])}.
]

{ #category : #'command line - arguments' }
PhLImageKillCliCommand class >> launcherCmdPositionals [
	^ {
		((ClapPositional id: #existingImageName)
				description: 'Selected image to kill.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'one argument is missing, there is no image name to kill' .   ];
					yourself)	.
	}
]

{ #category : #'command execution' }
PhLImageKillCliCommand >> execute [
	(arguments at: #all) value
		ifTrue: [ ^ (self killAllImages) ].
	^ self killSelectedImage 

]

{ #category : #commands }
PhLImageKillCliCommand >> killAllImages [
	
	^ LibC runCommand: (self killImageCmdStringFrom: nil)
]

{ #category : #commands }
PhLImageKillCliCommand >> killImageCmdStringFrom: anImageName [
	^ String
		streamContents: [ :aStream | 
			aStream nextPutAll: 'kill $(pgrep -a -f Pharo | grep -v ';
			nextPutAll: self currentVMPid asString.
			anImageName isEmptyOrNil
				ifFalse: [ aStream
						nextPutAll: ' | grep ';
						nextPutAll: anImageName ].
			aStream nextPutAll: ' | tr -s '' '' | cut -d '' '' -f1)> /dev/null' ]
]

{ #category : #commands }
PhLImageKillCliCommand >> killSelectedImage [

	^ LibC runCommand: (self killImageCmdStringFrom: self imageName)
]
