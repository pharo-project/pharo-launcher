*pharo-launcher-core
isBinary
	"answers whether the contents of a document of the receiving mime type are binary"
	"This method must not be in the pharo-launcher core. It currently is as a workaround for a soon-to-be-fixed bug in Zinc."
	| subTypes |
	self main = 'text' ifTrue: [ ^ false ].
	(self matches: self class applicationJson) ifTrue: [ ^ false ].
	self main = 'application' ifFalse: [ ^ true ].
	subTypes := self sub subStrings: '+'.
	^ subTypes noneSatisfy: [ :each | 
		#('x-javascript' 'xml') includes: each ]