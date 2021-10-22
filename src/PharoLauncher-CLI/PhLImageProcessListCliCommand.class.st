"
Command to list all the running images. 
"
Class {
	#name : #PhLImageProcessListCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #processList
]

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> launcherCmdDescription [
	^ 'Lists all running images on local computer.'
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> execute [
	"The brackets between the P of Pharo is to avoid to list the get procress when using ps x."
	"The grep -v ps is to avoid to list the pharo launcher image."
	
	"TODO rewrite use to OSSubProcess since execution can check exit code and result of bash command at once, libc can do just one or another"
	"TODO rewrite this to more meaningful output with columns like PID, datetime started, vm name, image name"
	
	self outStream 
		nextPutAll: (LibC resultOfCommand: self processListCmdString).
	^ self context exitSuccess 
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> processListCmdString [

	^ String streamContents: [ :aStream |		
		aStream 
			nextPutAll: 'bash -c "ps x | grep -i [P]haro | grep ''.image'' | grep -v ''.bash''| grep -v ';
			nextPutAll: self currentVMPid asString;
			nextPutAll: ' | tr -s '' '' | cut -d '' '' -f1,5,6- "'
	]
]
