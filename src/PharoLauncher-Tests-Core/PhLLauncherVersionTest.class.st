"
I specify how versions of Pharo Launcher are compared.
"
Class {
	#name : 'PhLLauncherVersionTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'tests' }
PhLLauncherVersionTest >> testCommitsAfterATagAreNotOlderThanTheTag [

	self deny: (self version: '3.4.5-12-gabcdef0') < (self version: '3.4.5')
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testCommitsAfterATagAreOlderThanTheNextVersion [

	self assert: (self version: '3.4.5-12-gabcdef0') < (self version: '3.4.6')
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testDevelopmentVersionIsNotComparable [

	self deny: (self version: 'N/A') isComparable.
	self deny: (self version: 'abcdef0') isComparable
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testMissingNumbersAreZero [

	self deny: (self version: '3.5') < (self version: '3.5.0').
	self deny: (self version: '3.5.0') < (self version: '3.5')
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testNumbersAreComparedAsNumbers [

	self assert: (self version: '3.9.0') < (self version: '3.10.0')
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testOlderVersion [

	self assert: (self version: '3.4.4') < (self version: '3.4.5').
	self deny: (self version: '3.4.5') < (self version: '3.4.4')
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testPreReleaseIsOlderThanRelease [

	self assert: (self version: '4.0-alpha-2') < (self version: '4.0').
	self assert: (self version: '3.4.5') < (self version: '4.0-alpha-2')
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testPrintsAsParsed [

	self assert: (self version: '3.4.5') printString equals: '3.4.5'
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testReleaseIsComparable [

	self assert: (self version: '3.4.5') isComparable
]

{ #category : 'tests' }
PhLLauncherVersionTest >> testSameVersionIsNotOlder [

	self deny: (self version: '3.4.5') < (self version: '3.4.5')
]

{ #category : 'helpers' }
PhLLauncherVersionTest >> version: aString [

	^ PhLLauncherVersion fromString: aString
]
