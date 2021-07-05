Extension { #name : #MacOSXPlatform }

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> canRun32bitApp [
	^ self version asInteger < 1015 "OS X Mojave 10.15 drop support of 32-bit application "
]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> hostArchitecture [
	^ (LibC resultOfCommand: 'uname -m') trim
]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> uname [
	^ PhLVmProvider osDarwin 
]
