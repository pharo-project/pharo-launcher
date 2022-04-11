Extension { #name : #PhLProcessWrapperTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLProcessWrapperTest >> setupProcessCmdWithArgs: argArray [

	^ PhLProcessWrapper new
		shellCommand;
		addAllArguments: argArray;
		yourself
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLProcessWrapperTest >> testAddAllArguments [

	|aWrapper|
	aWrapper := PhLProcessWrapper new.
	aWrapper addAllArguments: #('a' 'b').
	self assert: aWrapper arguments size equals: 2.
	self assert: aWrapper arguments first equals: 'a'.
	self assert: aWrapper arguments second equals: 'b'.
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLProcessWrapperTest >> testRunAndWaitWithStdOutput [

	"test if command normally returns content of stdout"
	self deny: (self setupProcessCmdWithArgs: #('ls')) runAndWaitWithStdOutput isEmptyOrNil.

	"wrong command raises exception with proper description"
	[ (self setupProcessCmdWithArgs: #('something')) runAndWaitWithStdOutput ]
		on: PhLProcessCommandError
		do: [ :ex | 
			self assert: (ex description includesSubstring: 'OS process command:').
			self assert: (ex description includesSubstring: 'Stderr contents:').
			self assert: (ex description includesSubstring: 'something') ]
]
