private
vmUrl
	| architecture pharoVersion |
	architecture := (self class is64bits: imageFormatNumber) ifTrue: [ '64' ] ifFalse: [ '' ].
	pharoVersion  := ((self class isPreSpur: imageFormatNumber) and: [ self imageVersion = '50' ])
		ifTrue: [ '50-preSpur' ]
		ifFalse: [ self imageVersion ].
	^ self vmUrlTemplate
		format: { pharoVersion . architecture . self downloadPathOSTypeSegment . 'stable' }