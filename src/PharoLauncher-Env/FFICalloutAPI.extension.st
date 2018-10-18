Extension { #name : #FFICalloutAPI }

{ #category : #'*PharoLauncher-Env' }
FFICalloutAPI >> function: functionSignature module: moduleNameOrLibrary [
	| sender ffiMethod ffiMethodSelector |
	sender := context ifNil: [ thisContext sender sender ].
	ffiMethodSelector := thisContext sender method selector.

	"Build new method"
	ffiMethod := self newBuilder
		build: [ :builder | 
			builder
				signature: functionSignature;
				sender: sender;
				module: moduleNameOrLibrary ].
	ffiMethod
		selector: sender selector;
		methodClass: sender methodClass.
	"Replace with generated ffi method, but save old one for future use"
	ffiMethod propertyValueAt: #ffiNonCompiledMethod put: (sender methodClass methodDict at: sender selector).
	"For senders search, one need to keep the selector in the properties"
	ffiMethod propertyValueAt: #ffiMethodSelector put: ffiMethodSelector.
	sender methodClass methodDict at: sender selector put: ffiMethod.
	"Register current method as compiled for ffi"
	FFIMethodRegistry uniqueInstance registerMethod: ffiMethod.
	"Resend"
	sender return: (sender receiver withArgs: sender arguments executeMethod: ffiMethod)
]
