Extension { #name : #MacOSXPlatform }

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> canRun32bitApp [
	^ self version asInteger < 1015 "OS X Mojave 10.15 drop support of 32-bit application "
]
