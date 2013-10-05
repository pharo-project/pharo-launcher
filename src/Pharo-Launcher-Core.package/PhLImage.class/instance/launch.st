action
launch
	"Use the VM that launched the current image to launch me"
	| vmCommand imagePath  |
	vmCommand := Smalltalk vm fullPath asString .
	imagePath := (file parent / file basename) pathString .
	OSProcess command: vmCommand , '   ' , imagePath.