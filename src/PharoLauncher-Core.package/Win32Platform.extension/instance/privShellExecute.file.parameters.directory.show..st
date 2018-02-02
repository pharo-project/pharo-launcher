*pharoLauncher-Core-Commands
privShellExecute: lpOperation file: lpFile parameters: lpParameters directory: lpDirectory show: nShowCmd
	
	^self ffiCall: #( 
			FFIConstantHandle ShellExecuteA(
     				0,
     				char* lpOperation,
         			char* lpFile,
     				char* lpParameters,
     				char* lpDirectory,
        			int nShowCmd)) module: #shell32
	
