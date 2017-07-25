private
ensureIsExecutable: aPath
	"Unzipping with Pharo does not preserve unix rights and so, the pahro VM executable does not have the execution permission.
	We have to set it explicitely on Unix and OS X."
	Smalltalk os isWindows 
		ifFalse: 	[ OSProcess waitForCommand: 'chmod u+x ' , aPath ]