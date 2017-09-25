intialization
initializeOn: aFolder
	| executables |
	executables := aFolder allChildrenMatching: self class executableName.
	Smalltalk os isUnix 
		ifTrue: [ 
			executables
				select: #isFile
				thenDo: [ :fileRef | self ensureIsExecutable: fileRef fullName ].
				"On linux, either the VM exe is at the top level or a bash script at the top level has to be used"
			executableRef := executables detect: [ :fileRef | fileRef parent = aFolder ].
			vmBinaryRef := executables detect: [ :fileRef | 
				fileRef binaryReadStreamDo:	[ :stream | (stream next: 4) = self class elfMagicNumber ] ] ]
		ifFalse: [ executableRef := vmBinaryRef := executables detect: #isFile ].
	self ensureIsExecutable: executableRef fullName.