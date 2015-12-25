action
launch: aFullPathString
	"Use the VM that launched the current image to launch me"

	| vmCommand imagePath |
	
	vmCommand := aFullPathString isEmpty
		ifTrue: [ Smalltalk vm fullPath asString ]
		ifFalse: [ aFullPathString ].
	imagePath := file pathString.
	
	^ OSProcess command: vmCommand , ' "' , imagePath , '"'