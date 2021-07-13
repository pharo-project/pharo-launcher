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
				description: 'New image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'one argument is missing, there is no image name to kill' .   ];
					yourself)	.
	}
]

{ #category : #'command execution' }
PhLImageKillCliCommand >> execute [
	(arguments at: #all) value
		ifTrue: [ ^ LibC
				runCommand: 'kill $(ps -aux | grep -i Pharo | grep image | awk ''{print $2}'') ' ].
	LibC
		runCommand:
			'kill $(ps -aux | grep -i Pharo | grep image | grep ' , self imageName
				, ' | awk ''{print $2}'') '
]
