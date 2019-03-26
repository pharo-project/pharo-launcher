Extension { #name : #OSProcess }

{ #category : #'*PharoLauncher-Core' }
OSProcess class >> isNonUnixMac [
	"True if the platform is Mac OS prior to OSX"

	"OSProcess isNonUnixMac"

	^ Smalltalk platform isMacOS and: [ Smalltalk platform isMacOSX not ]
]
