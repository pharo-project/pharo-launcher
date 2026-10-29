Class {
	#name : 'PhLCliProgressRunnerTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-CLI-Tests-Others',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Others'
}

{ #category : 'private' }
PhLCliProgressRunnerTest >> runOn: aStream doing: aBlock [

	^ ITProgressRunner
		use: (PhLCliProgressRunner on: aStream)
		during: [ PhLProgressManager displayProgress: 'test' during: aBlock ]
]

{ #category : 'tests' }
PhLCliProgressRunnerTest >> testDisplaysJobProgress [

	| output |
	output := String streamContents: [ :stream |
		self runOn: stream doing: [ :job | job max: 200; currentValue: 50 ] ].

	self assert: output equals: '[##        ] 25%' , OSPlatform current lineEnding
]

{ #category : 'tests' }
PhLCliProgressRunnerTest >> testErrorIsSignaledToTheCaller [

	self
		should: [ self runOn: String new writeStream doing: [ :job | PhLDownloadError signal ] ]
		raise: PhLDownloadError
]

{ #category : 'tests' }
PhLCliProgressRunnerTest >> testRunsTheWorkOnce [

	| count |
	count := 0.
	self runOn: String new writeStream doing: [ :job | count := count + 1 ].

	self assert: count equals: 1
]

{ #category : 'tests' }
PhLCliProgressRunnerTest >> testUnsubscribesFromJobsAtTheEnd [

	| subscriptionsCount |
	subscriptionsCount := Job jobAnnouncer numberOfSubscriptions.
	self runOn: String new writeStream doing: [ :job | job progress: 0.5 ].

	self assert: Job jobAnnouncer numberOfSubscriptions equals: subscriptionsCount
]
