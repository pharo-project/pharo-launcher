Extension { #name : #MacOSXPlatform }

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform class >> armArchitecture [
	^ 'arm64'
]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> canRun32bitApp [
	^ self version asInteger < 1015 "OS X Mojave 10.15 drop support of 32-bit application "
]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> hostArchitecture [
	| archName |
	archName := (LibC resultOfCommand: 'uname -m') trim.
	
	^ archName = self class intelArchitecture 
		ifTrue: [ (LibC resultOfCommand: 'sysctl -in sysctl.proc_translated') trim = '1' 
			ifTrue: [ "Running on Rosetta 2" self class armArchitecture ]
			ifFalse: [ "Running native Intel" archName ] ]
		ifFalse: [ archName ]

]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform class >> intelArchitecture [
	^ 'x86_64'
]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> uname [
	^ PhLVmProvider osDarwin 
]
