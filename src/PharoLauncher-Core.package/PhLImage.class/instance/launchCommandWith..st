action
launchCommandWith: vmCommand
	| command imagePath vmDirectoryPath |
	imagePath := file pathString.
	vmDirectoryPath := vmCommand asFileReference parent fullName.
	command := 'cd "' , vmDirectoryPath , '" && '.
	Smalltalk os isUnix 
		ifTrue: [ command := command , 'EXPORT SQUEAK_PLUGINS="" && ' ].
	command := $" asString , vmCommand , '"  "' , imagePath , '"'.
	^ command

