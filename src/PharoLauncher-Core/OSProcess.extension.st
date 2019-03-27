Extension { #name : #OSProcess }

{ #category : #'*PharoLauncher-Core' }
OSProcess class >> isNonUnixMac [
	"True if the platform is Mac OS prior to OSX"

	"OSProcess isNonUnixMac"

	^ Smalltalk platform isMacOS and: [ Smalltalk platform isMacOSX not ]
]

{ #category : #'*PharoLauncher-Core' }
OSProcess class >> isUnix [
	"True if the platform is Unix (including Linux, Mac OS X, or other unix-like OS).
	Note: Keep this method in sync with UnixOSProcessPlugin>>isResponsibleForThisPlatform."

	"OSProcess isUnix"

	^ Smalltalk platform isUnix or: [ Smalltalk platform isMacOSX ]
]
