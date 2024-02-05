"
Command to kill one image if given in option or all the images if the --all flag is set
"
Class {
	#name : #PhLProcessKillCliCommand,
	#superclass : #PhLProcessCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLProcessKillCliCommand class >> addLauncherFlagsTo: aCommandSpec [
	
	aCommandSpec 
		addFlag: #all 
		description: 'Determines whether to kill all running Pharo image processes.'
]

{ #category : #'command line - arguments' }
PhLProcessKillCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #existingImageName 
		description: 'Specifies the local image name to kill its process.')
	implicitMeaning: [ :arg :app | self raiseMissingImageToKill]
]

{ #category : #'command line - converting' }
PhLProcessKillCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #kill 
]

{ #category : #'command line - description' }
PhLProcessKillCliCommand class >> launcherCmdDescription [

	^ 'Kills the running process(es) of given local image.'
]

{ #category : #'error signalling' }
PhLProcessKillCliCommand class >> raiseMissingImageToKill [

	^ NotFound signal: 'An argument is missing, please specify the local image name to kill it process.'
]

{ #category : #'command execution' }
PhLProcessKillCliCommand >> basicExecute [
	"currently unsupported on Windows"
	self checkOS.
	
	^ self executeOSShellCommand 

]

{ #category : #testing }
PhLProcessKillCliCommand >> hasAllFlag [

	^ self hasFlag: #all
]

{ #category : #accessing }
PhLProcessKillCliCommand >> imageName [

	^ self positional: #existingImageName
]

{ #category : #commands }
PhLProcessKillCliCommand >> killArgString [

	^ String
		streamContents: [ :aStream | 
			aStream nextPutAll: '$(pgrep -a -f Pharo | grep -v ';
			nextPutAll: self currentVMPid asString.
			self hasAllFlag ifFalse: [ aStream
						nextPutAll: ' | grep ';
						nextPutAll:  self imageName ].
			aStream nextPutAll: ' | tr -s '' '' | cut -d '' '' -f1)>' ]
]

{ #category : #'command execution' }
PhLProcessKillCliCommand >> osShellArgArray [
	"provide the command and its args in array"

	^ Array 
		with: 'kill' 
		with: self killArgString
		with: '/dev/null'
]
