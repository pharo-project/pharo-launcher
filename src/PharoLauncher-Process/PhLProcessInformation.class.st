Class {
	#name : #PhLProcessInformation,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_PROCESS',
		'OFFSET_PROCESSID',
		'OFFSET_THREAD',
		'OFFSET_THREADID'
	],
	#category : #'PharoLauncher-Process'
}

{ #category : #'field definition' }
PhLProcessInformation class >> fieldsDesc [
	^ #(
		void * process;
		void * thread;
		uint processId;
		uint threadId;
	)
]

{ #category : #initialization }
PhLProcessInformation >> initialize [
	super initialize.
	PhLProcess clear: self
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> process [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PROCESS) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> process: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PROCESS put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> processId [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_PROCESSID
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> processId: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_PROCESSID put: anObject
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> thread [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_THREAD) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> thread: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_THREAD put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> threadId [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_THREADID
]

{ #category : #'accessing structure variables' }
PhLProcessInformation >> threadId: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_THREADID put: anObject
]
