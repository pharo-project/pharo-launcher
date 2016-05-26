action
launchCommandWith: vmCommand
	| command imagePath |
	imagePath := file pathString.
	command := $" asString , vmCommand , '"  "' , imagePath , '"'.
	^ command