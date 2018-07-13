expected results
currentImageVersion
	
	"This test must be rewritten to a controlable version not depending on current image version"
	self skip. 

	^ (SystemVersion current major = 6
		and: [ SystemVersion current highestUpdate >= 60509 ])
		ifTrue: [ '61' ]
		ifFalse: [ SystemVersion current major asString
				, SystemVersion current minor asString ]