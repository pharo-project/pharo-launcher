"
I specify the icons with a red badge telling a number, like the notifications of macOS.
"
Class {
	#name : 'PhLBadgedIconTest',
	#superclass : 'TestCase',
	#instVars : [
		'icon'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'asserting' }
PhLBadgedIconTest >> assertIsRed: aColor [

	self assert: (aColor red > 0.8 and: [ aColor green < 0.3 and: [ aColor blue < 0.3 ] ])
]

{ #category : 'running' }
PhLBadgedIconTest >> setUp [

	super setUp.
	icon := Form extent: 16 @ 16 depth: 32.
	icon fillColor: Color blue
]

{ #category : 'tests' }
PhLBadgedIconTest >> testBadgeIsInTheTopRightCorner [

	| form |
	form := (PhLBadgedIcon icon: icon count: 2) asForm.

	self assertIsRed: (form colorAt: (form width - 6) @ 1)
]

{ #category : 'tests' }
PhLBadgedIconTest >> testCountAboveNineIsShortened [

	self assert: (PhLBadgedIcon icon: icon count: 12) text equals: '9+'
]

{ #category : 'tests' }
PhLBadgedIconTest >> testIconIsBelowTheBadge [

	| form |
	form := (PhLBadgedIcon icon: icon count: 2) asForm.

	self assert: (form colorAt: 0 @ (form height - 1)) equals: Color blue
]

{ #category : 'tests' }
PhLBadgedIconTest >> testNoBadgeWithoutCount [

	self assert: (PhLBadgedIcon icon: icon count: 0) asForm identicalTo: icon
]

{ #category : 'tests' }
PhLBadgedIconTest >> testTextIsTheCount [

	self assert: (PhLBadgedIcon icon: icon count: 2) text equals: '2'
]
