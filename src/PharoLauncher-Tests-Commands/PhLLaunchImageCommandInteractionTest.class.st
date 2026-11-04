"
I test the interactions with the user when launching an image: launch errors and architecture mismatch warnings.
"
Class {
	#name : 'PhLLaunchImageCommandInteractionTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'warnOnArchMismatch',
		'quitOnLaunch'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'helper' }
PhLLaunchImageCommandInteractionTest >> launchDoing: aBlock [

	^ (PhLLaunchImageCommand new
		context: presenter;
		yourself) launchImage: (PhLTestLaunchableImage new
			launchBlock: aBlock;
			yourself)
]

{ #category : 'private' }
PhLLaunchImageCommandInteractionTest >> performTest [

	PharoLauncherApplication useDefault: presenter application during: [ super performTest ]
]

{ #category : 'running' }
PhLLaunchImageCommandInteractionTest >> setUp [

	super setUp.
	warnOnArchMismatch := PhLLaunchImageCommand warnOnArchMismatch.
	quitOnLaunch := PhLLaunchImageCommand quitOnLaunch.
	PhLLaunchImageCommand warnOnArchMismatch: true.
	PhLLaunchImageCommand quitOnLaunch: false.
	presenter := PhLTestImagesPresenter new
]

{ #category : 'helper' }
PhLLaunchImageCommandInteractionTest >> signalWarning [

	PhLArchitectureMismatchWarning signalLauncherArch: '64-bit' imageArch: '32-bit'
]

{ #category : 'running' }
PhLLaunchImageCommandInteractionTest >> tearDown [

	PhLLaunchImageCommand warnOnArchMismatch: warnOnArchMismatch.
	PhLLaunchImageCommand quitOnLaunch: quitOnLaunch.
	super tearDown
]

{ #category : 'tests' }
PhLLaunchImageCommandInteractionTest >> testConfirmingWarningGoesOnWithLaunch [

	| result |
	result := self launchDoing: [ self signalWarning. #process ].

	self assert: result equals: #process.
	self assert: (presenter request message includesSubstring: '32-bit')
]

{ #category : 'tests' }
PhLLaunchImageCommandInteractionTest >> testLaunchErrorIsShownToTheUser [

	| error |
	error := PhLCorruptedTemplateError new.

	self launchDoing: [ error signal ].

	self assert: presenter information message equals: error longDescription
]

{ #category : 'tests' }
PhLLaunchImageCommandInteractionTest >> testOnlyOneConfirmationIsAskedForALaunch [

	| result |
	result := self launchDoing: [
		self signalWarning.
		"A second confirmation would be refused"
		presenter confirmationAnswer: false.
		self signalWarning.
		#process ].

	self assert: result equals: #process
]

{ #category : 'tests' }
PhLLaunchImageCommandInteractionTest >> testRefusingWarningStopsLaunch [

	| launched result |
	presenter confirmationAnswer: false.
	launched := false.

	result := self launchDoing: [ self signalWarning. launched := true ].

	self assert: result isNil.
	self deny: launched
]

{ #category : 'tests' }
PhLLaunchImageCommandInteractionTest >> testUnhandledWarningDoesNotInteractWithUser [

	| reached |
	reached := false.

	self signalWarning.
	reached := true.

	self assert: reached
]

{ #category : 'tests' }
PhLLaunchImageCommandInteractionTest >> testWarningIsNotShownWhenDisabledInSettings [

	| result |
	PhLLaunchImageCommand warnOnArchMismatch: false.
	presenter confirmationAnswer: false.

	result := self launchDoing: [ self signalWarning. #process ].

	self assert: result equals: #process
]
