Class {
	#name : #PhLStartupInfo,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_CB',
		'OFFSET_DESKTOP',
		'OFFSET_FILLATTRIBUTE',
		'OFFSET_FLAGS',
		'OFFSET_RESERVED',
		'OFFSET_RESERVED2',
		'OFFSET_RESERVED3',
		'OFFSET_SHOWWINDOW',
		'OFFSET_STDERROR',
		'OFFSET_STDINPUT',
		'OFFSET_STDOUTPUT',
		'OFFSET_TITLE',
		'OFFSET_X',
		'OFFSET_XCOUNTCHARS',
		'OFFSET_XSIZE',
		'OFFSET_Y',
		'OFFSET_YCOUNTCHARS',
		'OFFSET_YSIZE'
	],
	#category : #'PharoLauncher-Process'
}

{ #category : #'field definition' }
PhLStartupInfo class >> fieldsDesc [
	"self rebuildFieldAccessors"
	^ #(
		uint cb;
		char * reserved;
		char * desktop;
		char * title;
		uint x;
		uint y;
		uint xSize;
		uint ySize;
		uint xCountChars;
		uint yCountChars;
		uint fillAttribute;
		uint flags;
		ushort showWindow;
		ushort reserved2;
		char * reserved3;
		void * stdInput;
		void * stdOutput;
		void * stdError;
	)
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> cb [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CB
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> cb: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CB put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> desktop [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DESKTOP) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> desktop: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DESKTOP put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> fillAttribute [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_FILLATTRIBUTE
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> fillAttribute: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_FILLATTRIBUTE put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> flags [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_FLAGS
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> flags: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_FLAGS put: anObject
]

{ #category : #initialization }
PhLStartupInfo >> initialize [
	super initialize.
	PhLProcess clear: self.
	self cb: self class structureSize
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> reserved [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_RESERVED) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> reserved2 [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_RESERVED2
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> reserved2: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_RESERVED2 put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> reserved3 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_RESERVED3) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> reserved3: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_RESERVED3 put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> reserved: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_RESERVED put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> showWindow [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_SHOWWINDOW
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> showWindow: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_SHOWWINDOW put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> stdError [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_STDERROR) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> stdError: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_STDERROR put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> stdInput [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_STDINPUT) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> stdInput: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_STDINPUT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> stdOutput [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_STDOUTPUT) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> stdOutput: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_STDOUTPUT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> title [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_TITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> title: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_TITLE put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> x [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_X
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> x: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_X put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> xCountChars [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_XCOUNTCHARS
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> xCountChars: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_XCOUNTCHARS put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> xSize [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_XSIZE
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> xSize: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_XSIZE put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> y [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_Y
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> y: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_Y put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> yCountChars [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_YCOUNTCHARS
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> yCountChars: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_YCOUNTCHARS put: anObject
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> ySize [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_YSIZE
]

{ #category : #'accessing structure variables' }
PhLStartupInfo >> ySize: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_YSIZE put: anObject
]
