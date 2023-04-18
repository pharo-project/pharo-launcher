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
MacOSXPlatform >> isValid: aPhLVirtualMachine [
	
	| executableArchitecture |
	executableArchitecture := Character space split: (self architectureOf: aPhLVirtualMachine executablePath).
	executableArchitecture := executableArchitecture collect: [ :each | each trimBoth ].
	(executableArchitecture includes: #executable) ifFalse: [ ^ false ].
	
	"64 bits exe and 32-bit PhLVirtualMachine or vice-versa"
	((executableArchitecture includes: '64-bit') xor: [ aPhLVirtualMachine is64bit ]) 
		ifTrue: [ ^ false ].
	
	(executableArchitecture includes: 'arm64') 
		ifTrue: [ ^ self processorArchitecture = 'arm64' ]
		ifFalse: [ self processorArchitecture = 'arm64' 
						ifTrue: [ self warnWhenWillLaunchInTranslatedMode ] ].
	
	^ true
]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> uname [
	^ PhLVmProvider osDarwin 
]

{ #category : #'*PharoLauncher-Core' }
MacOSXPlatform >> warnWhenWillLaunchInTranslatedMode [	
	
	PhLTranslatedModeWarning signal
	
	
]
