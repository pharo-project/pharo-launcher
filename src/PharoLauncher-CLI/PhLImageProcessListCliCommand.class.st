"
Command to list all the running images. 
"
Class {
	#name : #PhLImageProcessListCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #processList
]

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> launcherCmdDescription [

	^ 'Lists all running Pharo image processes.'
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> basicExecute [
	
	"TODO rewrite this to more meaningful output with columns like PID, datetime started, vm name, image name"
	"TODO: Win Powershell version should be something like this: Get-Process | Where-Object { $_.Path -like '*Pharo*' -and $_.Path -like '*.image*' -and $_.Id -ne 2232 } | Select-Object Id, Path, StartTime, CommandLine"
	self checkOS.
	self outStream 
		nextPutAll: self executeOSShellCommand.
	^ self context exitSuccess 
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> execute [
	
	"TODO rewrite this to more meaningful output with columns like PID, datetime started, vm name, image name"
	"TODO: Win Powershell version should be something like this: Get-Process | Where-Object { $_.Path -like '*Pharo*' -and $_.Path -like '*.image*' -and $_.Id -ne 2232 } | Select-Object Id, Path, StartTime, CommandLine"
	self checkOS.
	self outStream 
		nextPutAll: self executeOSShellCommand.
	^ self context exitSuccess 
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> osShellArgArray [ 

	^ Array with: 'echo' with: '-n' with: ('$(pgrep -a -f Pharo | grep ''.image'' | grep -v ''.bash''| grep -v {1})' format: {self currentVMPid asString})

]
