Extension { #name : #OSWSWinProcess }

{ #category : #'*PharoLauncher-CLI' }
OSWSWinProcess >> runAndWaitWithStdOutput [
	"this is dummy implementation, TODO: handle std ourput, err output on windows"

	self runAndWait.
	^ ''
]
