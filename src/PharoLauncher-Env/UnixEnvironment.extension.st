Extension { #name : #UnixEnvironment }

{ #category : #'*PharoLauncher-Env' }
UnixEnvironment >> getEnvironmentVariable: aVariableNameString [
	"This method receives as argument the name of an environment variable as a Pharo String.
	It returns a Pharo String with the value of the variable (if env var found), or throws an exception if not found.
	
	This method does a best effort to use the right encoding to encode/decode the variable names and the return value.
	Different strategies could be used in different platforms."
	
	^ self getEnvironmentVariable: aVariableNameString withEncoding: self platformEncoding
]

{ #category : #'*PharoLauncher-Env' }
UnixEnvironment >> getEnvironmentVariable: aVariableNameString withEncoding: anEncoding [
	" Warning: low-level. Use only if you want to have control over the encoding.
	
	This method receives as argument the name of an environment variable as a Pharo String.
	It returns a Pharo String with the value of the variable (if env var found), or throws an exception if not found.
	
	This method encodes the variable names and the return value using the given encoding."
	
	^ (self getRawEnvironmentVariable: (aVariableNameString encodeWith: anEncoding)) decodeWith: anEncoding
]

{ #category : #'*PharoLauncher-Env' }
UnixEnvironment >> getRawEnvironmentVariable: encodedVarName [
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
]

{ #category : #'*PharoLauncher-Env' }
UnixEnvironment >> getRawEnvironmentVariableViaFFI: varName [
	"This method calls the Standard C Library getenv() function.
	This method receives a ByteArray with the encoded version of the name to lookup.
	It is up to the user to correctly encode the name.

	It returns an ExternalData with a null pointer if the variable is not found.	
	It returns an ExternalData pointing to the raw bytes of the value of the variable if found.
	It is up to to the user to correctly decode the value."
	 ^ self ffiCall: #( ByteArray getenv (ByteArray varName) ) module: LibC
]

{ #category : #'*PharoLauncher-Env' }
UnixEnvironment >> platformEncoding [

	"Determine the current encoding of the platform for environment variables.
	This encoding is platform dependent.
	
	Use UTF8 by default"
	
	^ ZnCharacterEncoder utf8
]
