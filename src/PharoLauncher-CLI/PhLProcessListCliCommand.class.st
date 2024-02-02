"
Command to list all the Pharo processes, i.e. all running Pharo images.
"
Class {
	#name : #PhLProcessListCliCommand,
	#superclass : #PhLProcessCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLProcessListCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	self addPrintFlagsTo: aCommandSpec.
]

{ #category : #'command line - converting' }
PhLProcessListCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #list
]

{ #category : #'command line - description' }
PhLProcessListCliCommand class >> launcherCmdDescription [

	^ 'Lists all running Pharo image processes.'
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> basicExecute [
	|processList|
	"TODO: Win Powershell version should be something like this: Get-Process | Where-Object { $_.Path -like '*Pharo*' -and $_.Path -like '*.image*' -and $_.Id -ne 2232 } | Select-Object Id, Path, StartTime, CommandLine"
	self checkOS.
	
	"trim trailing newlines"
	processList := self imageProcesListFrom: self executeOSShellCommand trim.
	self list: processList
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> getImageAttributesFrom: lineString [

	| lineWords pid imagePath vmPath startDate |
	
	lineWords := lineString substrings.
	pid := self pidStringFrom: lineWords.
	vmPath := self vmPathFrom: lineWords.
	imagePath := self imagePathFrom: lineWords.
	startDate := self startDateOfPid: pid.
	^ {pid. vmPath. imagePath. startDate}
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> imagePathFrom: lineWords [

	| pharoVMIndex pharoImgIndex resultImgString |
	"find index of word containing pharo VM name"
	pharoVMIndex := lineWords
		                detectIndex: [ :word | word includesSubstring: 'pharo' caseSensitive: false ]
		                ifNone: [ ^ '' ].
	"find index of word containing pharo image file"
	pharoImgIndex := lineWords
		                 detectIndex: [ :word | word includesSubstring: '.image' caseSensitive: false ]
		                 ifNone: [ 0 ].
	resultImgString := String streamContents: [ :aStream |
		                   lineWords
			                   from: pharoVMIndex + 1
			                   to: pharoImgIndex
			                   do: [ :word |
				                   (word beginsWith: '--') ifFalse: [
					                   aStream
						                   nextPutAll: word;
						                   nextPut: Character space ] ].
		                   lineWords
			                   from: pharoImgIndex + 1
			                   to: lineWords size
			                   do: [ :word |
				                   (word beginsWith: '--') ifTrue: [
					                   aStream
						                   nextPutAll: word;
						                   nextPut: Character space ] ] ].

	^ resultImgString trim
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> imageProcesListFrom: shellOutput [

	^ (shellOutput substrings: OSPlatform current lineEnding)  collect: [:line |
			PhLImageProcess newFrom: (self getImageAttributesFrom: line)
	]
]

{ #category : #private }
PhLProcessListCliCommand >> modelClass [

 ^ self class environment at: #PhLImageProcess
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> osShellArgArray [

	^ Array with: self processListCmdArgs
]

{ #category : #private }
PhLProcessListCliCommand >> pidStringFrom: lineWords [

	"pid is the first word of line"
	^ lineWords first
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> processListCmdArgs [

	"process grep of all processes with 'pharo' (case-insensitive), where launcher process is ommited as well as export commands for path env. variables"
	^ String streamContents: [:aStream |
		aStream 
			nextPutAll: OSPlatform current processListArgs;
			nextPutAll: ' | grep -v ".bash"| grep -v "export LD_LIBRARY_PATH" | grep -v ';
			nextPutAll: self currentVMPid asString;
			"returns 0 exit code also for cases, when no process is found. (default for no match is 1)"
			nextPutAll: '; pgrep_exit_code=$?; if [ "$pgrep_exit_code" -eq 1 ]; then exit 0; else exit "$pgrep_exit_code"; fi'			
		]
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> startDateOfPid: pidString [

	|pidDateCmd |
	pidDateCmd := String streamContents: [: aStream |
		aStream 
			nextPutAll:  'ps -o lstart= -p "';
			nextPutAll: pidString;
			nextPutAll: '" | ';
			nextPutAll: OSPlatform current processStartDateArgs.
	].
	^ (self executeOSShellCommandWithArgs: (Array with: pidDateCmd)) trim
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> vmPathFrom: lineWords [

	|pharoVMIndex pharoImgIndex resultVmString|
	"find index of word containing pharo VM name"
	pharoVMIndex := lineWords detectIndex: [:word | word includesSubstring: 'pharo' caseSensitive: false] ifNone: [^ ''].
	"find index of word containing pharo image file"
	pharoImgIndex := lineWords detectIndex: [:word | word includesSubstring: '.image' caseSensitive: false] ifNone: [0].
	resultVmString := String streamContents: [:aStream | 
		lineWords from: 2 to: pharoVMIndex do: [:word | aStream nextPutAll: word; nextPut: Character space].
		lineWords from: pharoVMIndex to: pharoImgIndex do: [:word | 
			(word beginsWith: '--') ifTrue: [ aStream nextPutAll: word; nextPut: Character space ].
			  ]
	].

	^ resultVmString trim
]
