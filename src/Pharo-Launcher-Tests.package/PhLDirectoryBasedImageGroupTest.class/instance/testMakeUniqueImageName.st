tests-action
testMakeUniqueImageName
	| group groupNames |
	group := self emptyGroup.  "Only for calling the method. It does not touch object state."
	groupNames := { }.	
	{ 	'30444' -> { } -> '30444' .
	 	'30444' -> { 'test' } -> '30444' .
		'30444' -> { 'test' . '30444' } -> '30444-01' .
		'30444' -> { 'test' . '30444' . '30444-01' } -> '30444-02' .
		'30444' -> { 'test' . '30444' . '30444-01' . '30444-02' } -> '30444-03' .
		'30444' -> { 'test' . '30444' . '30444-01' . '30444-09' } -> '30444-10' .
		'30444' -> { 'test' . '30444' . '30444-11' . '30444-09' } -> '30444-12' .
	} do:
	[ 	:asn |  | basename existingNames expectedResult result |
		basename := asn key key.
		existingNames := asn key value.
		expectedResult := asn value value.
		result := group makeUniqueImageName: basename among: existingNames.
		self assert: result equals: expectedResult.
	]
