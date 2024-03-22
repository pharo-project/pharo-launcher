Extension { #name : #DeleteVisitor }

{ #category : #'*PharoLauncher-Tests-Functional' }
DeleteVisitor >> visitReference: anEntry [
	self traceCr: '[DeleteVisitor] deleting ' , anEntry fullName.
	anEntry reference delete
]
