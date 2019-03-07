Class {
	#name : #PLAbstractSpecTestCase,
	#superclass : #TestCase,
	#instVars : [
		'instance',
		'window',
		'testImage',
		'modifiedTime'
	],
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #testing }
PLAbstractSpecTestCase class >> isAbstract [

	^ self == PLAbstractSpecTestCase
]

{ #category : #tests }
PLAbstractSpecTestCase >> setUp [ 

	super setUp.
	modifiedTime := DateAndTime now.
	testImage := PhLMockImage named: 'TestImage' arch: '32' modified: modifiedTime.

]

{ #category : #tests }
PLAbstractSpecTestCase >> tearDown [

	instance ifNotNil: [ :x | x application close ].
	super tearDown

]
