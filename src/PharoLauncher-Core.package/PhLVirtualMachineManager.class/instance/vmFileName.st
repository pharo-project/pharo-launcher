accessing
vmFileName
	| architecture |
	architecture := (self class is64bits: self imageFormatNumber)
		ifTrue: [ 'x64' ]
		ifFalse: [ 'x86' ].
	^ self imageVersion , '-' , architecture.