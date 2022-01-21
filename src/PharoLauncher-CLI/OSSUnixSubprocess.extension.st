Extension { #name : #OSSUnixSubprocess }

{ #category : #'*PharoLauncher-CLI' }
OSSUnixSubprocess >> argumentsString [

	^ Character space join: self argVArguments allButLast
]

{ #category : #'*PharoLauncher-CLI' }
OSSUnixSubprocess >> getExceptionMessageFor: cmdString status: statusMsg stdError: errorString [

	^ String streamContents: [:aStream | 
		aStream 
			nextPutAll: ('OS process command: ''{1}''  exited with: {2}.' format: {cmdString. statusMsg.});
			nextPutAll: OSPlatform current lineEnding;
			nextPutAll: ('Stderr contents: "{1}".' format: {errorString}).
	]
]

{ #category : #'*PharoLauncher-CLI' }
OSSUnixSubprocess >> runAndWaitWithStdOutput [
	"this is helper method to catch std. output and return to sender of this method, 
	 exit codes are handled and proper exception is raised, when not successful
	"

	self 
		redirectStdout;
		redirectStderr;
		runAndWaitOnExitDo: [ :termProcess :outString :errString | 
			termProcess isSuccess
				ifTrue: [ ^ outString ]
				ifFalse: [ | exceptionMessage |
					exceptionMessage := self
						getExceptionMessageFor: self argumentsString
						status: termProcess exitStatusInterpreter printString
						stdError: errString.
					PhLProcessCommandError signal: exceptionMessage ] ]
]
