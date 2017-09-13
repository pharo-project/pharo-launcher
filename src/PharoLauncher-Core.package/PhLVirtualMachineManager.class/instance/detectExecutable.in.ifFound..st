private
detectExecutable: executableName in: aFolder ifFound: foundBlock
	| executables |
	executables := aFolder allChildrenMatching: executableName.
	^ Smalltalk os isUnix 
		ifTrue: [ executables
				select: #isFile
				thenDo: [ :fileRef | self ensureIsExecutable: fileRef fullName ].
				"On linux, either the VM exe is at the top level or a bash script at the top level has to be used"
				executables
					detect: [ :fileRef | fileRef parent = aFolder ]
					ifFound: foundBlock ]
		ifFalse: [ executables 
				detect: #isFile
				ifFound: foundBlock ]