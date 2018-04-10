*PharoLauncher-Spec
nodePathWith: anOrderedCollection
	
	self parentNode isNil 
		ifFalse: [ 
			self parentNode nodePathWith: anOrderedCollection  ].
		
	^anOrderedCollection 
			add: self;
			yourself