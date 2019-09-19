"
I represent a Pharo virtual machine that can be used to run image.

executableRef is a reference to the script/binary to actually use to launch images.
vmBinaryRef is a reference to the vm binary (not a bash file).
"
Class {
	#name : #PhLVirtualMachine,
	#superclass : #Object,
	#instVars : [
		'executableRef',
		'vmBinaryRef',
		'name',
		'manager'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #'instance creation' }
PhLVirtualMachine class >> directory: aFileReference [
	^ self 
		directory: aFileReference
		private: false
]

{ #category : #'instance creation' }
PhLVirtualMachine class >> directory: aFileReference private: isPrivateVm [
	| targetClass |
	targetClass := isPrivateVm ifTrue: [ PhLPrivateVirtualMachine ] ifFalse: [ self ].
	^ targetClass new 
		initializeOn: aFileReference;
		yourself 
]

{ #category : #accessing }
PhLVirtualMachine class >> elfMagicNumber [
	^ ByteArray newFrom: #(127 69 76 70)
]

{ #category : #querying }
PhLVirtualMachine class >> executableName [
	^ PlatformResolver forCurrentPlatform vmExecutableName
]

{ #category : #querying }
PhLVirtualMachine >> archPath [
	| arch |
	arch := (name last: 3).
	arch = 'x64' ifTrue: [ ^ '64' ].
	^ ''
]

{ #category : #intialization }
PhLVirtualMachine >> basicInitializeOn: aFolder [
	name := aFolder basename
]

{ #category : #querying }
PhLVirtualMachine >> downloadUrl [
	^ self manager vmUrlTemplate
		format: { self pharoVersion . self archPath . self manager downloadPathOSTypeSegment . 'stable' }
]

{ #category : #ensuring }
PhLVirtualMachine >> ensureIsExecutable: aPath [
	"Unzipping with Pharo does not preserve unix rights and so, the pahro VM executable does not have the execution permission.
	We have to set it explicitely on Unix and OS X."
	Smalltalk os isWindows 
		ifFalse: 	[ PhLProcessWrapper new 
			shellCommand;
			addArguments: 'chmod u+x';
			addArgument: aPath surroundedByDoubleQuotes;
			runAndWaitTimeOut: 5 seconds ]
]

{ #category : #setting }
PhLVirtualMachine >> executable: aPathOrfileReference [
	executableRef := aPathOrfileReference asFileReference
]

{ #category : #accessing }
PhLVirtualMachine >> executableFolderPath [
	^ executableRef parent fullName
]

{ #category : #accessing }
PhLVirtualMachine >> executablePath [
	^ executableRef fullName
]

{ #category : #testing }
PhLVirtualMachine >> ifValid: aBlockClosure [ 
	(executableRef isNotNil and: [ vmBinaryRef isNotNil ])
		ifTrue: [ aBlockClosure value ]
]

{ #category : #intialization }
PhLVirtualMachine >> initializeExecutableRefFrom: aFolder [
	| executables |
	executables := aFolder allChildrenMatching: self class executableName.
	Smalltalk os isUnix
		ifTrue: [ executables select: #isFile thenDo: [ :fileRef | self ensureIsExecutable: fileRef fullName ].
			"On linux, either the VM exe is at the top level or a bash script at the top level has to be used"
			executableRef := executables
				detect: [ :fileRef | fileRef parent = aFolder ]
				ifNone: [ PhLExecutableNotFoundError signalKind: 'executable' inPath: aFolder fullName ].
			vmBinaryRef := executables
				detect: [ :fileRef | fileRef binaryReadStreamDo: [ :stream | (stream next: 4) = self class elfMagicNumber ] ]
				ifNone: [ PhLExecutableNotFoundError signalKind: 'VM binary' inPath: aFolder fullName ] ]
		ifFalse:
			[ executableRef := vmBinaryRef := executables detect: #isFile ifNone: [ PhLExecutableNotFoundError signalKind: 'executable' inPath: aFolder fullName ] ].
	self ensureIsExecutable: executableRef fullName
]

{ #category : #intialization }
PhLVirtualMachine >> initializeOn: aFolder [
	self basicInitializeOn: aFolder.
	self initializeExecutableRefFrom: aFolder.
]

{ #category : #querying }
PhLVirtualMachine >> lastUpdateTime [
	^ executableRef modificationTime
]

{ #category : #updating }
PhLVirtualMachine >> manager [
	^ manager ifNil: [ manager := PhLVirtualMachineManager new ]
]

{ #category : #accessing }
PhLVirtualMachine >> manager: aPhLVirtualMachineManager [ 
	manager := aPhLVirtualMachineManager
]

{ #category : #accessing }
PhLVirtualMachine >> name [
	^ name
]

{ #category : #querying }
PhLVirtualMachine >> pharoVersion [
	^ ($- split: name ) first
]

{ #category : #printing }
PhLVirtualMachine >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #actions }
PhLVirtualMachine >> removeFromSystem [
	| vmFolder zipFile |
	vmFolder := self vmStore / self name.
	vmFolder exists
		ifTrue: [ vmFolder ensureDeleteAll ].
	zipFile := self vmStore / (self name, '.zip').
	zipFile exists
		ifTrue: [ zipFile ensureDelete ].

]

{ #category : #actions }
PhLVirtualMachine >> showInFolder [
	PhLFileBrowser openOn: self vmStore / name
]

{ #category : #updating }
PhLVirtualMachine >> update [
	"fetch a new version of this Virtual Machine if available"
	self manager class 
		fetch: self downloadUrl
		to: self name
]

{ #category : #setting }
PhLVirtualMachine >> vmBinary: aPathOrFileReference [
	vmBinaryRef := aPathOrFileReference asFileReference
]

{ #category : #accessing }
PhLVirtualMachine >> vmFolder [
	^ vmBinaryRef parent
]

{ #category : #accessing }
PhLVirtualMachine >> vmFolderPath [
	^ self vmFolder fullName
]

{ #category : #accessing }
PhLVirtualMachine >> vmStore [
	^ self manager vmStore
]
