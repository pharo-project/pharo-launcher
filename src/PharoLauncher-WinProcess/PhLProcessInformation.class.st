"
Structure needed to make FFI calls to createProcess.
It contains information about a newly created process and its primary thread.
See PhLProcess class for more information.
documentation: https://docs.microsoft.com/en-us/windows/desktop/api/processthreadsapi/ns-processthreadsapi-process_information
"
Class {
	#name : #PhLProcessInformation,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_DWPROCESSID',
		'OFFSET_DWTHREADID',
		'OFFSET_HPROCESS',
		'OFFSET_HTHREAD'
	],
	#pools : [
		'PhLWinTypes'
	],
	#category : #'PharoLauncher-WinProcess'
}

{ #category : #'field definition' }
PhLProcessInformation class >> fieldsDesc [
	"self rebuildFieldAccessors"
	
	^ #(
	HANDLE hProcess;
	HANDLE hThread;
	DWORD  dwProcessId;
	DWORD  dwThreadId;	
	)
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> dwProcessId [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWPROCESSID
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> dwProcessId: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWPROCESSID put: anObject
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> dwThreadId [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWTHREADID
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> dwThreadId: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWTHREADID put: anObject
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> hProcess [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HPROCESS) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> hProcess: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HPROCESS put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> hThread [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HTHREAD) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> hThread: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HTHREAD put: anObject getHandle.
]

{ #category : #initialization }
PhLProcessInformation >> initialize [
	super initialize.
	PhLWinProcessLibrary clear: self
]
