"
Command to list all the running images. 
"
Class {
	#name : #PhLImageProcessListCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageProcessListCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	self addPrintFlagsTo: aCommandSpec.
]

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #processList
]

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> launcherCmdDescription [

	^ 'Lists all running Pharo image processes.'
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> basicExecute [
	|processList|
	"TODO: Win Powershell version should be something like this: Get-Process | Where-Object { $_.Path -like '*Pharo*' -and $_.Path -like '*.image*' -and $_.Id -ne 2232 } | Select-Object Id, Path, StartTime, CommandLine"
	self checkOS.
	
	"trim trailing newlines"
	processList := self imageProcesListFrom: self executeOSShellCommand trim.
	self list: processList
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> getImageAttributesFrom: lineString [
	|lineWords pid imagePath vmPath startDate|
	lineWords := lineString substrings.
	pid := self pidStringFrom: lineWords.
	vmPath := self vmPathFrom: lineWords. 
	imagePath := self imagePathFrom: lineWords.
	startDate := self startDateOfPid: pid. 
	^ {pid. vmPath. imagePath. startDate}
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> imagePathFrom: lineWords [

	|pharoVMIndex pharoImgIndex resultImgString|
	"find index of word containing pharo VM name"
	pharoVMIndex := lineWords detectIndex: [:word | word includesSubstring: 'pharo' caseSensitive: false] ifNone: [^ ''].
	"find index of word containing pharo image file"
	pharoImgIndex := lineWords detectIndex: [:word | word includesSubstring: '.image' caseSensitive: false] ifNone: [0].
	resultImgString := String streamContents: [:aStream | 
		lineWords from: pharoVMIndex + 1 to: pharoImgIndex do: [:word |
			(word beginsWith: '--') ifFalse: [
			 aStream 
					nextPutAll: word; 
					nextPut: Character space]
		].
		lineWords from: pharoImgIndex + 1 to: lineWords size do: [:word | 
			(word beginsWith: '--') ifTrue: [ aStream nextPutAll: word; nextPut: Character space ].
			  ]
	].

	^ resultImgString trim
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> imageProcesListFrom: shellOutput [

	^ (shellOutput substrings: OSPlatform current lineEnding)  collect: [:line |
			PhLImageProcess newFrom: (self getImageAttributesFrom: line)
	]
]

{ #category : #private }
PhLImageProcessListCliCommand >> modelClass [

 ^ self class environment at: #PhLImageProcess
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> osShellArgArray [

	^ Array with: self processListCmdArgs
]

{ #category : #private }
PhLImageProcessListCliCommand >> pidStringFrom: lineWords [

	"pid is the first word of line"
	^ lineWords first
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> processListCmdArgs [

	"process grep of all processes with 'pharo' (case-insensitive), where launcher process is ommited as well as export commands for path env. variables"
	^ String streamContents: [:aStream |
		aStream 
			nextPutAll: OSPlatform current processListArgs;
			nextPutAll: ' | grep -v ".bash"| grep -v "export LD_LIBRARY_PATH" | grep -v ';
			nextPutAll: self currentVMPid asString;
			"return 0 exit code also for cases, when no process is found. (default for no match is 1)"
			nextPutAll: '; pgrep_exit_code=$?; if [ "$pgrep_exit_code" -eq 1 ]; then exit 0; else exit "$pgrep_exit_code"; fi'			
		]
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> startDateOfPid: pidString [

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
PhLImageProcessListCliCommand >> vmPathFrom: lineWords [

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
