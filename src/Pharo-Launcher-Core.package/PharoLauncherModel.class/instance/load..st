runnnig
load: aString 	
	self listElement do: [ :each | (each name asString = aString) ifTrue: [ self loadAndRun: each ] ].