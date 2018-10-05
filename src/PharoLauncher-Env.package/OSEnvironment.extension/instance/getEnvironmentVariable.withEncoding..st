*PharoLauncher-Env
getEnvironmentVariable: aVariableNameString withEncoding: anEncoding
	" Warning: low-level. Use only if you want to have control over the encoding.
	
	This method receives as argument the name of an environment variable as a Pharo String.
	It returns a Pharo String with the value of the variable (if env var found), or throws an exception if not found.
	
	This method encodes the variable names and the return value using the given encoding."
	
	^ (self getRawEnvironmentVariable: (aVariableNameString encodeWith: anEncoding)) decodeWith: anEncoding