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
	processList := self imageProcesListFrom: self executeOSShellCommand.
	self list: processList
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> imageProcesListFrom: shellOutput [
	|debugArgs processListUnformatted|
	debugArgs  := Array with: ('pgrep -ai -f ''pharo.*\.image'' | grep -v ''.bash''| grep -v ''export LD_LIBRARY_PATH'' | grep -v {1}' format: {self currentVMPid asString}).
	processListUnformatted := self executeOSShellCommandWithArgs: debugArgs.
	self logInfoMessage: '*** Printing unformatted Pharo process data:'.
	self logInfoMessage: processListUnformatted.
	self logInfoMessage: '*** Printing information from formatted OS output:'.
	self logInfoMessage: shellOutput.
	self logInfoMessage: '*** End of debug printing.'.
	^ (shellOutput substrings: OSPlatform current lineEnding)  collect: [:line |
			PhLImageProcess newFrom: (line splitOn: self processListDelimiter)
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

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> processListCmdArgs [

	|separator|
	separator := self processListDelimiter.	
	^ String streamContents: [:aStream |
		aStream 
			nextPutAll: 'pgrep -ai -f ''pharo.*\.image'' | grep -v ''.bash''| grep -v ''export LD_LIBRARY_PATH'' | grep -v ';
			nextPutAll: self currentVMPid asString;
			nextPutAll: ' | while read -r line; do'; lf;
			nextPutAll: '	pid=$(echo "$line" | awk ''{print $1}'')'; lf;
			
			"This captures the entire cmd line (excluding the PID) and stores it in the cmd variable"
			nextPutAll: '  cmd=$(echo "$line" | cut -d'' '' -f2-)'; lf;
			
			"This extracts the vmPath by capturing everything up to the first occurrence of .image."
			nextPutAll: '  vmPath=$(echo "$cmd" | sed -E ''s/([^ ]+\.image).*/\1/'')'; lf;
			
			"This extracts the imgPath by capturing everything after .image."
			nextPutAll: '  imgPath=$(echo "$cmd" | sed -E ''s/[^ ]+\.image (.*)/\1/'')'; lf;
			
			nextPutAll: '	start_time=$(ps -o lstart= -p "$pid")'; lf;
			nextPutAll: '	echo "$pid'; << separator; << '$vmPath'; << separator; << '$imgPath'; << separator; << '$start_time"'; lf;
			nextPutAll: 'done'
		]
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> processListDelimiter [
	
	"this delimiter is used when using OS process output to obtain Pharo process information"
	^ '-|-'
]
