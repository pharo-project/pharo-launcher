action
launchCommandWith: vmCommand
	| command imagePath vmDirectoryPath |
	imagePath := file pathString.
	vmDirectoryPath := vmCommand asFileReference parent fullName.
	command := 'cd "' , vmDirectoryPath , '" && '.
	Smalltalk os isUnix 
		ifTrue: [ command := command , 'export SQUEAK_PLUGINS="" && ' ].
	command := command , $" asString , vmCommand , '"  "' , imagePath , '"'.
	^ command

