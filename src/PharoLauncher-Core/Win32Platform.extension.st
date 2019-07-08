Extension { #name : #Win32Platform }

{ #category : #'*PharoLauncher-Core' }
Win32Platform >> privShellExecute: lpOperation file: lpFile parameters: lpParameters directory: lpDirectory show: nShowCmd [
	
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
Win32Platform >> privShellExplore: folder [
	"
	self privShellExplore: 'c:\'
	"

	^self privShellExecute: 'explore' file: folder parameters: '' directory: '' show: 5 "SW_SHOW"
]
