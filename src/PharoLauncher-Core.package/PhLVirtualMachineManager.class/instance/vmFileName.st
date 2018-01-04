accessing
vmFileName
	| architecture pharoVersion |
	architecture := (self class is64bits: self imageFormatNumber)
		ifTrue: [ 'x64' ]
		ifFalse: [ 'x86' ].
	pharoVersion  := ((self class isPreSpur: self imageFormatNumber) and: [ self imageVersion = '50' ])
		ifTrue: [ '50-preSpur' ]
		ifFalse: [ self imageVersion ].
	^ pharoVersion , '-' , architecture.