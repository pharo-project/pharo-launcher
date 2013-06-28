action
launch
	"Use the VM that launched the current image to launch me"
	| cdCommand vmCommand |
	cdCommand := 'cd "' , file parent pathString, '"'.
	vmCommand := Smalltalk vm fullPath asString , ' "' , file basename, '"'.
	OSProcess command: cdCommand , ' && ' , vmCommand