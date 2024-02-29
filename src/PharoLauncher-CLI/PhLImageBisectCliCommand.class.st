"
I represent Pharo Image copy sub-command invoked from cmd line of Pharo Launcher. My responsibility is to implement a dichotomic search to find the first image where the evaluation of a script will be true.
"
Class {
	#name : #PhLImageBisectCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'workingDirectory',
		'pharoVersion',
		'builds'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageBisectCliCommand class >> addLauncherFlagsTo: aCommandSpec [
	aCommandSpec 
		addFlagWithPositional: #pharoVersion 
		description: 'Pharo version number to use for bisection (default is the current development Pharo version)'
]

{ #category : #'command line' }
PhLImageBisectCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #bisect
]

{ #category : #'command line' }
PhLImageBisectCliCommand class >> launcherCmdDescription [

	^ 'Do a dichotomic search to find the first image where the evaluation of a script will be true.'
]

{ #category : #'command execution' }
PhLImageBisectCliCommand >> askEvaluationResultToUser: buildNumber [

	^ (self cliInputRequest
		question: ('Does Pharo image build #{1} have a correct behavior? [y|n]' format: { buildNumber asString });
		useShortYesNoValidation;
		answer) = 'y'
]

{ #category : #'command execution' }
PhLImageBisectCliCommand >> askForFirstKnownFaultyImage [

	^ self cliInputRequest
		  question:
			  ('What is the first known faulty image (build number)? [{1}]'
				   format: { self builds last });
		  transform: [ :answer |
			  answer trim
				  ifEmpty: [ self builds last ]
				  ifNotEmpty: [ Integer readFrom: answer ] ];
		  validation: [ :aNumber | self builds includes: aNumber ];
		  validationErrorMessage: self inputBuildNumberValidationMessage;
		  answer
]

{ #category : #'command execution' }
PhLImageBisectCliCommand >> askForLastKnownCorrectImage [

	^ self cliInputRequest
		  question:
			  ('What is the last known correct image (build number)? [{1}]'
				   format: { self builds first });
		  transform: [ :answer |
			  answer trim
				  ifEmpty: [ self builds first ]
				  ifNotEmpty: [ Integer readFrom: answer ] ];
		  validation: [ :aNumber | self builds includes: aNumber ];
		  validationErrorMessage: self inputBuildNumberValidationMessage;
		  answer
]

{ #category : #'command execution' }
PhLImageBisectCliCommand >> basicExecute [

	| bisection faultyBuild knownFaultybuild correctBuild |
	self logInfoMessage: 'Collecting Pharo images build numbers ...'.
	builds := PhLImageFinder buildsForPharoVersion: self pharoVersion.
	knownFaultybuild := self askForFirstKnownFaultyImage.
	correctBuild := self askForLastKnownCorrectImage.
	bisection := PhLImageBisection on: builds from: correctBuild to: knownFaultybuild.
	bisection evaluationBlock: [ :buildNumber | self createAndLaunchImageAndGetEvaluationFromUser: buildNumber ].
	"remove working directory?"
	faultyBuild := bisection result.
	self logInfoMessage: ('Found faulty image! Image build #{1} is the culprit!' format: { faultyBuild }).
	^ faultyBuild
]

{ #category : #accessing }
PhLImageBisectCliCommand >> builds [
	
	^ builds
]

{ #category : #accessing }
PhLImageBisectCliCommand >> computePharoVersion [

	^ (self hasFlag: #pharoVersion)
		  ifTrue: [ (self positional: #pharoVersion) asInteger ]
		  ifFalse: [ self pharoDevelopmentVersion allButLast "remove 0 of minor version" ]
]

{ #category : #'command execution' }
PhLImageBisectCliCommand >> createAndLaunchImageAndGetEvaluationFromUser: buildNumber [

	self createImage: buildNumber.
	^ self askEvaluationResultToUser: buildNumber
]

{ #category : #'command execution' }
PhLImageBisectCliCommand >> createImage: buildNumber [

	| createImagecontext command |
	createImagecontext := ClapContext specification: PhLCliCommand launcherCommand.
	createImagecontext setStdio: self context stdio.
	command := (createImagecontext arguments:
		            { 'launcher'. 'image'. 'create'. 'fromBuild'. buildNumber asString . '--pharoVersion'. self pharoVersion }) command.
	command pharoLauncherModel imageRepository: (PhLDirectoryBasedImageRepository forDirectory: self workingDirectory).
	command pharoLauncherModel consoleInputRequest: self pharoLauncherModel consoleInputRequest.
	command execute
]

{ #category : #initialization }
PhLImageBisectCliCommand >> initialize [ 
	
	super initialize.
	workingDirectory := self workingDirectory
]

{ #category : #accessing }
PhLImageBisectCliCommand >> inputBuildNumberValidationMessage [

	^ 'Please provide a valid build number: image build number must be between {1 and {2}!'
		  format: {
				  self builds first.
				  self builds last }
]

{ #category : #accessing }
PhLImageBisectCliCommand >> pharoDevelopmentVersion [
	
	"url looks like https://files.pharo.org/image/120/latest-64.zip"
	
	^ self latestDevTemplate url segments second
]

{ #category : #accessing }
PhLImageBisectCliCommand >> pharoVersion [

	"The pharo version containing image builds to bisect"
	
	^ pharoVersion ifNil: [ pharoVersion := self computePharoVersion ]
]

{ #category : #configuring }
PhLImageBisectCliCommand >> workingDirectory [
	
	| timestamp |
	timestamp := DateAndTime now printString copyUpTo: $+.
	^ (FileLocator temp / ('pl-bisect-' , timestamp)) asFileReference   
]
