tests-action
testMakeUniqueImageName
	
	{ 
	"	{ basename . 	expectedResult .	{existingNames} } "	
		{ '30444' .		'30444' . 			{ } } .
	 	{ '30444' .		'30444' . 			{ 'test' } } .
		{ '30444' .		'30444-01' .		{ 'test' . '30444' } } .
		{ '30444' .		'30444-02' .		{ 'test' . '30444' . '30444-01' } } .
		{ '30444' .		'30444-03' .		{ 'test' . '30444' . '30444-01' . '30444-02' } } .
		{ '30444' .		'30444-10' .		{ 'test' . '30444' . '30444-01' . '30444-09' } } .
		{ '30444' .		'30444-12' .		{ 'test' . '30444' . '30444-11' . '30444-09' } } .
		{ '30444' . 		'30444-12' .		{ 'test' . '30444' . '30444-11' . '30444-09' . '30444-test' . '30644-Case12954' } } .		
	} do:
	[ 	:testdata |  
		| basename expectedResult existingNames result |
		basename := testdata first.
		expectedResult := testdata second. 
		existingNames := testdata third.
		
		result := self emptyGroup makeUniqueImageName: basename among: existingNames.
		self assert: result equals: expectedResult.
	]
 

