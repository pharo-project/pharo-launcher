"
Command to kill one image if given in option or all the images if the --all flag is set 
"
Class {
	#name : #PhLImageKillCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
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

{ #category : #accessing }
PhLImageKillCliCommand >> allFlag [

	^ (arguments at: #all) value
]

{ #category : #'command execution' }
PhLImageKillCliCommand >> execute [
	
	^ self executeOSShellCommand 

]

{ #category : #commands }
PhLImageKillCliCommand >> killArgString [

	^ String
		streamContents: [ :aStream | 
			aStream nextPutAll: '$(pgrep -a -f Pharo | grep -v ';
			nextPutAll: self currentVMPid asString.
			self allFlag ifFalse: [ aStream
						nextPutAll: ' | grep ';
						nextPutAll:  self imageName ].
			aStream nextPutAll: ' | tr -s '' '' | cut -d '' '' -f1)>' ]
]

{ #category : #'command execution' }
PhLImageKillCliCommand >> osShellArgArray [

	"provide list of command and its args in array"
	^ Array with: 'kill' with: self killArgString with: '/dev/null'
]

{ #category : #commands }
PhLImageKillCliCommand >> sndKillArgString [

	^ String
		streamContents: [ :aStream | 
			aStream nextPutAll: '$(pgrep -a -f Pharo | grep -v ';
			nextPutAll: self currentVMPid asString.
			self allFlag ifFalse: [ aStream
						nextPutAll: ' | grep ';
						nextPutAll:  self imageName ].
			aStream nextPutAll: ' | tr -s '' '' | cut -d '' '' -f1)>' ]
]
