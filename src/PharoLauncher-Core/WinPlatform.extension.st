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
WinPlatform >> isValid: aPhLVirtualMachine [
	"Maybe we should read the PE format:
	- https://learn.microsoft.com/en-gb/windows/win32/menurc/enumerating-resources?redirectedfrom=MSDN
	- https://learn.microsoft.com/en-us/windows/win32/debug/pe-format.
	For now, we do not check anything. "

	^ true
]

{ #category : #'*PharoLauncher-Core' }
WinPlatform >> uname [
	^ PhLVmProvider osWindows
]
