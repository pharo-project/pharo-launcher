Extension { #name : #WinPlatform }

{ #category : #'*PharoLauncher-Core' }
WinPlatform >> hostArchitecture [
	| processorArch |
	processorArch := OSEnvironment current at: 'PROCESSOR_ARCHITECTURE'.
	(#(AMD64 x64) includes: processorArch asSymbol)
		ifTrue: [ processorArch :=  self class archX86_64 ].
	^ processorArch 
]

{ #category : #'*PharoLauncher-Core' }
WinPlatform >> uname [
	^ PhLVmProvider osWindows
]
