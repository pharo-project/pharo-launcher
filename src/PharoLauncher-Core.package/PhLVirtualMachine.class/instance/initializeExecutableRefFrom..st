intialization
initializeExecutableRefFrom: aFolder
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