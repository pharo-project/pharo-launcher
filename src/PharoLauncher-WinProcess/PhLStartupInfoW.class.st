"
Structure needed to make FFI calls to createProcess.
Specifies the window station, desktop, standard handles, and appearance of the main window for a process at creation time.
See PhLWinProcess class for more information.
Documentation: https://docs.microsoft.com/fr-fr/windows/desktop/api/processthreadsapi/ns-processthreadsapi-_startupinfow
"
Class {
	#name : #PhLStartupInfoW,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_CB',
		'OFFSET_CBRESERVED2',
		'OFFSET_DWFILLATTRIBUTE',
		'OFFSET_DWFLAGS',
		'OFFSET_DWX',
		'OFFSET_DWXCOUNTCHARS',
		'OFFSET_DWXSIZE',
		'OFFSET_DWY',
		'OFFSET_DWYCOUNTCHARS',
		'OFFSET_DWYSIZE',
		'OFFSET_HSTDERROR',
		'OFFSET_HSTDINPUT',
		'OFFSET_HSTDOUTPUT',
		'OFFSET_LPDESKTOP',
		'OFFSET_LPRESERVED',
		'OFFSET_LPRESERVED2',
		'OFFSET_LPTITLE',
		'OFFSET_WSHOWWINDOW'
	],
	#pools : [
		'PhLWinTypes'
	],
	#category : #'PharoLauncher-WinProcess'
}

{ #category : #'field definition' }
PhLStartupInfoW class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	DWORD	cb;
	LPWSTR	lpReserved;
	LPWSTR	lpDesktop;
	LPWSTR	lpTitle;
	DWORD	dwX;
	DWORD	dwY;
	DWORD	dwXSize;
	DWORD	dwYSize;
	DWORD	dwXCountChars;
	DWORD	dwYCountChars;
	DWORD	dwFillAttribute;
	DWORD	dwFlags;
	WORD	 wShowWindow;
	WORD	 cbReserved2;
	LPBYTE lpReserved2;
	HANDLE hStdInput;
	HANDLE hStdOutput;
	HANDLE hStdError;
)
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> cb [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CB
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> cb: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CB put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> cbReserved2 [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_CBRESERVED2
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> cbReserved2: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_CBRESERVED2 put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwFillAttribute [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWFILLATTRIBUTE
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwFillAttribute: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWFILLATTRIBUTE put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwFlags [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWFLAGS
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwFlags: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWFLAGS put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwX [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWX
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwX: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWX put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwXCountChars [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWXCOUNTCHARS
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwXCountChars: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWXCOUNTCHARS put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwXSize [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWXSIZE
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwXSize: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWXSIZE put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwY [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWY
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwY: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWY put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwYCountChars [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWYCOUNTCHARS
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwYCountChars: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWYCOUNTCHARS put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwYSize [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWYSIZE
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> dwYSize: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWYSIZE put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> hStdError [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HSTDERROR) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> hStdError: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HSTDERROR put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> hStdInput [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HSTDINPUT) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> hStdInput: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HSTDINPUT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> hStdOutput [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HSTDOUTPUT) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> hStdOutput: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HSTDOUTPUT put: anObject getHandle.
]

{ #category : #initialization }
PhLStartupInfoW >> initialize [
	super initialize.
	PhLWinProcessLibrary clear: self
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpDesktop [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPDESKTOP) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpDesktop: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPDESKTOP put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpReserved [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPRESERVED) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpReserved2 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPRESERVED2) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpReserved2: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPRESERVED2 put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpReserved: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPRESERVED put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPTITLE) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> lpTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPTITLE put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> wShowWindow [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_WSHOWWINDOW
]

{ #category : #'accessing structure variables' }
PhLStartupInfoW >> wShowWindow: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_WSHOWWINDOW put: anObject
]
