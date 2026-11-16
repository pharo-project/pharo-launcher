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

{ #category : 'tests' }
PhLUpdateCheckerTest >> testFailingCheckDoesNotPreventOtherChecks [
	"The checks are done again later: an error must not stop the process doing them"

	| done checker |
	done := OrderedCollection new.
	checker := PhLUpdateChecker checks: {
			           [ Error signal: 'check failed' ].
			           [ done add: #virtualMachines ] }.

	self shouldnt: [ checker check ] raise: Error.

	self assert: done asArray equals: #( #virtualMachines )
]
