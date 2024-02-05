"
Command to list all the Pharo processes, i.e. all running Pharo images.
"
Class {
	#name : #PhLProcessListCliCommand,
	#superclass : #PhLProcessCliCommand,
	#instVars : [
		'shellOutput'
	],
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
	shellOutput := self executeOSShellCommand trim.
	processList := self imageProcesList.
	self list: processList
]

{ #category : #private }
PhLProcessListCliCommand >> getImageProcessFrom: lineString [

	| imageProcess |
	
	imageProcess :=  PhLImageProcess newFrom: lineString.
	imageProcess startDateTime: (self startDateOfPid: imageProcess pid).
	^ imageProcess
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> imageProcesList [

	^ (shellOutput substrings: OSPlatform current lineEnding)
		collect: [:line | self getImageProcessFrom: line ]
]

{ #category : #private }
PhLProcessListCliCommand >> modelClass [

 ^ self class environment at: #PhLImageProcess
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> osShellArgArray [

	^ Array with: self processListCmdArgs
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

{ #category : #private }
PhLProcessListCliCommand >> startDateOfPid: pidString [

	| pidDateCmd |
	pidDateCmd := String streamContents: [: aStream |
		aStream 
			nextPutAll:  'LANG=C ps -o lstart= -p "';
			nextPutAll: pidString;
			nextPutAll: '" | ';
			nextPutAll: OSPlatform current processStartDateArgs.
	].
	^ (self executeOSShellCommandWithArgs: (Array with: pidDateCmd)) trim
]
