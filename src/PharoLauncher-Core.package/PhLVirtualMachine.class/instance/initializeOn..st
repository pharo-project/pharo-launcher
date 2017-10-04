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
			executableRef := executables 
				detect: [ :fileRef | fileRef parent = aFolder ]
				ifNone: [ self error: 'Cannot detect Pharo executable in ' , aFolder fullName ].
			vmBinaryRef := executables 
				detect: [ :fileRef | 
					fileRef binaryReadStreamDo:	[ :stream | (stream next: 4) = self class elfMagicNumber ] ]
				ifNone: [ self error: 'Cannot detect Pharo VM binary in ' , aFolder fullName ] ]
		ifFalse: [ executableRef := vmBinaryRef := executables 
			detect: #isFile
			ifNone: [ self error: 'Cannot detect Pharo executable in ' , aFolder fullName ] ].
	self ensureIsExecutable: executableRef fullName.