*PharoLauncher-Env
getRawEnvironmentVariableViaFFI: varName
	"This method calls the Standard C Library getenv() function.
	This method receives a ByteArray with the encoded version of the name to lookup.
	It is up to the user to correctly encode the name.

	It returns an ExternalData with a null pointer if the variable is not found.	
	It returns an ExternalData pointing to the raw bytes of the value of the variable if found.
	It is up to to the user to correctly decode the value."
	 ^ self ffiCall: #( ByteArray getenv (ByteArray varName) ) module: LibC