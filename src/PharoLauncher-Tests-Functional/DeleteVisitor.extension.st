Extension { #name : #DeleteVisitor }

{ #category : #'*PharoLauncher-Tests-Functional' }
DeleteVisitor >> visitReference: anEntry [

	anEntry isDirectory 
		ifTrue: [ 
			self traceCr: '[DeleteVisitor] deleting directory: ' , anEntry fullName.
			anEntry reference entries do: [ :each | self traceCr: '[DeleteVisitor] directory entry: ' , each fullName ]
			 ]
		ifFalse: [ self traceCr: '[DeleteVisitor] deleting file: ' , anEntry fullName. ].
	anEntry reference delete
]
