public
cleanMyClassVariables
	"self cleanMyClassVariables"
	
	self classesClassVariablesToClean do: 
	[	:myClassPool | 
		Transcript crShow: myClassPool printString.
		myClassPool keysDo: [  :key | myClassPool at: key put: nil ].
	].
	Smalltalk garbageCollect.
	self myInstancesSummary inspect.
