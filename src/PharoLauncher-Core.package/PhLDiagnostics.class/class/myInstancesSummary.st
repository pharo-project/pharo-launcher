public
myInstancesSummary
	"self myInstancesSummary"
	| result |
	Smalltalk garbageCollect.
	result := Bag new.
	self myInstances do: [ :instance | result add: instance class printString ]. 
	^result sortedCounts