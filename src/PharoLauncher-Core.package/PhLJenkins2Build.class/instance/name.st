accessing
name
	^ String streamContents: [:str |
		self isLastSuccessful 
			ifTrue: [ str nextPutAll: 'Latest sucessful build: ' ].
		str 
			nextPut: $#;
		 	print: self number]