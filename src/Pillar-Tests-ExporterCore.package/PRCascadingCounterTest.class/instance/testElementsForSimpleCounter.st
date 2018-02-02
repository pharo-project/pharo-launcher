tests
testElementsForSimpleCounter
	| counter |
	counter := PRCascadingCounter maxLevel: 5.
	self assert: counter elements equals: { 0 }.
	counter incrementAt: 1.
	self assert: counter elements equals: { 1 }