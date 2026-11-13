Class {
	#name : 'PhLUpdateCheckerTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'tests' }
PhLUpdateCheckerTest >> testChecksAreDoneOneAfterTheOther [

	| done checker |
	done := OrderedCollection new.
	checker := PhLUpdateChecker checks: {
			           [ done add: #templateSources ].
			           [ done add: #virtualMachines ] }.

	checker check.

	self assert: done asArray equals: #( #templateSources #virtualMachines )
]
