tests
testElementsForNonSimpleCounter
	| counter |
	counter := PRCascadingCounter maxLevel: 5.
	self assert: counter elements equals: { 0 }.
	counter incrementAt: 2.
	self assert: counter elements equals: { 0 . 1 }