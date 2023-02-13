"
Command to kill one image if given in option or all the images if the --all flag is set 
"
Class {
	#name : #PhLImageKillCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageKillCliCommand class >> addLauncherFlagsTo: aCommandSpec [
	
	aCommandSpec 
		addFlag: #all 
		description: 'Determines whether to kill all running Pharo image processes.'.
	"
	^ {((ClapFlag id: #all)
		description: 'Determines whether to kill all running Pharo image processes. ';
		meaning: [ :arg :app | true ];
		implicitMeaning: [ :arg :app | false ])}."
]

{ #category : #'command line - arguments' }
PhLImageKillCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	aCommandSpec 
		addPositional: #existingImageName 
		description: 'Specifies the local image name to kill its process.'.
	"^ {
		((ClapPositional id: #existingImageName)
				description: 'Specifies the local image name to kill its process.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'An argument is missing, please specify the local image name to kill it process.'];
					yourself)	.
	}"
]

{ #category : #'command line' }
PhLImageKillCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #kill 
]

{ #category : #'command line' }
PhLImageKillCliCommand class >> launcherCmdDescription [

	^ 'Kills the running process(es) of given local image.'
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