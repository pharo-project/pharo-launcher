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
	^ self newLauncherCommand: #ps
]

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> launcherCmdDescription [
	^ 'Lists all running images on local computer.'
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> execute [
	"The brackets between the P of Pharo is to avoid to list the get procress whn using ps x."
	"The grep -v ps is to avoid to list the pharo launcher image."
	LibC
		runCommand:
			'ps x | grep -i [P]haro | grep ''.image'' | grep -v "ps$" | tr -s '' '' | cut -d '' '' -f1,5,6-'
		
]
