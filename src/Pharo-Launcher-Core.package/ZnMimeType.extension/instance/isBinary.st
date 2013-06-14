*pharo-launcher-core
isBinary
	"answers whether the contents of a document of the receiving mime type are binary"
	| subTypes |
	self main = 'text' ifTrue: [ ^ false ].
	(self matches: self class applicationJson) ifTrue: [ ^ false ].
	self main = 'application' ifFalse: [ ^ true ].
	subTypes := self sub subStrings: '+'.
	^ subTypes noneSatisfy: [ :each | 
		#('x-javascript' 'xml') includes: each ]