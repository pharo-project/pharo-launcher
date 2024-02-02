"
Command to list all the Pharo processes, i.e. all running Pharo images.
"
Class {
	#name : #PhLProcessListCliCommand,
	#superclass : #PhLProcessCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLProcessListCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #list
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> basicExecute [
	
	"TODO rewrite this to more meaningful output with columns like PID, datetime started, vm name, image name"
	"TODO: Win Powershell version should be something like this: Get-Process | Where-Object { $_.Path -like '*Pharo*' -and $_.Path -like '*.image*' -and $_.Id -ne 2232 } | Select-Object Id, Path, StartTime, CommandLine"
	
	self checkOS.
	self outStream 
		nextPutAll: self executeOSShellCommand.
	^ self context exitSuccess 
]

{ #category : #'command execution' }
PhLProcessListCliCommand >> osShellArgArray [ 

	^ Array with: 'echo' with: '-n' with: ('$(pgrep -a -f Pharo | grep ''.image'' | grep -v ''.bash''| grep -v {1})' format: {self currentVMPid asString})
]
