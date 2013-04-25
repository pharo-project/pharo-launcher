runnnig
load: aString 	
	self listElement do: [ :each | Transcript cr; show: aString, '- ', each name asString.(each name asString = aString) ifTrue: [ self loadAndRun: each ] ].