"
https://github.com/Bajger/Pharo-snippets/blob/master/pharoLauncherCmdLine-description.md

"
Class {
	#name : #ClapListImages,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
ClapListImages class >> listImages [
	<commandline>
	^ (ClapCommand withName: 'listImages')
		description: 'Lists all downloaded images on local computer.';
		add: ClapFlag forHelp;
		meaning: [ :args |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
         self outputListImages 
		 ]
]

{ #category : #'instance creation' }
ClapListImages class >> outputListImages [
	self new 
	outputListImages.
]

{ #category : #initialization }
ClapListImages >> initialize [
	stream := VTermOutputDriver stdout
]

{ #category : #printing }
ClapListImages >> outputListImages [ 
	stream nextPutAll: 'blabla'.
	stream flush
		
]
