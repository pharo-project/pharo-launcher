*PharoLauncher-Env
getEnvironmentVariable: aVariableNameString
	"This method receives as argument the name of an environment variable as a Pharo String.
	It returns a Pharo String with the value of the variable (if env var found), or throws an exception if not found.
	
	This method does a best effort to use the right encoding to encode/decode the variable names and the return value.
	Different strategies could be used in different platforms."
	
	^ self getEnvironmentVariable: aVariableNameString withEncoding: self platformEncoding