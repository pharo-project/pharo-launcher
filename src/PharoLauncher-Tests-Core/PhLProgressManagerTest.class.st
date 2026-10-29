"
I test that long running operations run without any UI showing their progress.
"
Class {
	#name : 'PhLProgressManagerTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'private' }
PhLProgressManagerTest >> displayProgressDuring: aBlock [
	"Use the default runner: no UI shows the progress"

	^ ITProgressRunner
		use: ITProgressRunner new
		during: [ PhLProgressManager displayProgress: 'test' during: aBlock ]
]

{ #category : 'tests' }
PhLProgressManagerTest >> testAnswersTheWorkResult [

	self assert: (self displayProgressDuring: [ :job | 42 ]) equals: 42
]

{ #category : 'tests' }
PhLProgressManagerTest >> testErrorIsSignaledToTheCaller [

	self
		should: [ self displayProgressDuring: [ :job | PhLDownloadError signal ] ]
		raise: PhLDownloadError
]

{ #category : 'tests' }
PhLProgressManagerTest >> testHttpProgressUpdatesTheJob [

	| progress |
	self displayProgressDuring: [ :job |
		(HTTPProgress new total: 200; amount: 50; yourself) signal.
		progress := job progress ].

	self assert: progress equals: 1 / 4
]

{ #category : 'tests' }
PhLProgressManagerTest >> testRunsTheWorkOnce [

	| count |
	count := 0.
	self displayProgressDuring: [ :job | count := count + 1 ].

	self assert: count equals: 1
]
