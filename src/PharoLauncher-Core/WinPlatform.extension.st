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
WinPlatform >> privShellExecute: lpOperation file: lpFile parameters: lpParameters directory: lpDirectory show: nShowCmd [
	
	^self ffiCall: #( 
			FFIConstantHandle ShellExecuteA(
     				0,
     				char* lpOperation,
         			char* lpFile,
     				char* lpParameters,
     				char* lpDirectory,
        			int nShowCmd)) module: #shell32
	

]

{ #category : #'*PharoLauncher-Core' }
WinPlatform >> privShellExplore: folder [
	"
	self privShellExplore: 'c:\'
	"

	^self privShellExecute: 'explore' file: folder parameters: '' directory: '' show: 5 "SW_SHOW"
]

{ #category : #'*PharoLauncher-Core' }
WinPlatform >> uname [
	^ PhLVmProvider osWindows
]
