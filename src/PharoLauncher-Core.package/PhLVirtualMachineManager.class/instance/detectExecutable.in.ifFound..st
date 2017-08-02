private
detectExecutable: executableName in: aFolder ifFound: foundBlock
	^ (aFolder allChildrenMatching: executableName)
		detect: [ :fileRef | 
			fileRef isFile 
				and: [ Smalltalk os isUnix not 
					or: [ "Unix, needs more checks to discard bash scripts having the same name"	
						fileRef binaryReadStreamDo:
							[ :stream | (stream next: 4) = self elfMagicNumber ] ] ] ]
		ifFound: foundBlock