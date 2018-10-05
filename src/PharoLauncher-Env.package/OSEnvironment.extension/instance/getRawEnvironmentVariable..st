*PharoLauncher-Env
getRawEnvironmentVariable: encodedVarName
	" WARNING: low level function"
	"This method receives as argument the name of an environment variable encoded into a byte array (using for example UTF8 or UTF32).
	It returns a byte array with an encoded version of the value of the variable (if env var found).
	It is your responsibility to decode it with the appropriate encoder to get a valid String.
	To get a decoded String, please use getEnvironmentVariable: ."
	
	| result |
	result := self getRawEnvironmentVariableViaFFI: encodedVarName.
	result isNull 
		ifTrue: [ NotFound signal: 'Cannot find ' , encodedVarName printString , ' environment variable' ]
		ifFalse: [ ^ result readByteArray ]