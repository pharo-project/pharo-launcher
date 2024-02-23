"
I represent Pharo Image copy sub-command invoked from cmd line of Pharo Launcher. My responsibility is to implement a dichotomic search to find the first image where the evaluation of a script will be true.
"
Class {
	#name : #PhLImageBisectCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'workingDirectory',
		'pharoVersion'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

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
PhLImageBisectCliCommand >> basicExecute [

	| bisection builds faultyBuild |
	builds := PhLImageFinder buildsForPharoVersion: self pharoVersion.
	"self askfForLastKnownFaultyImage"
	"self askForLastKnownCorrectImage"
	bisection := PhLImageBisection on: builds from: 4"1376" to: 1397"1390".
	bisection evaluationBlock: [ :buildNumber | self createAndLaunchImageAndGetEvaluationFromUser: buildNumber ].
	"remove working directory?"
	faultyBuild := bisection result.
	self logInfoMessage: ('Found faulty image! Image build #{1} is the culprit!' format: { faultyBuild }).
	^ faultyBuild
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
	createImagecontext setStdio: Stdio"self context stdio".
	command := (createImagecontext arguments:
		            { 'launcher'. 'image'. 'create'. 'fromBuild'. buildNumber asString . '--pharoVersion'. self pharoVersion }) command.
	command pharoLauncherModel imageRepository: (PhLDirectoryBasedImageRepository forDirectory: self workingDirectory).
	command execute
]

{ #category : #initialization }
PhLImageBisectCliCommand >> initialize [ 
	
	super initialize.
	workingDirectory := self workingDirectory
]

{ #category : #accessing }
PhLImageBisectCliCommand >> pharoDevelopmentVersion [
	
	"url looks like https://files.pharo.org/image/120/latest-64.zip"
	
	^ self latestDevTemplate url segments second
]

{ #category : #accessing }
PhLImageBisectCliCommand >> pharoVersion [

	"The pharo version containing image builds to bisect"
	
	^ pharoVersion ifNil: [ pharoVersion := self pharoDevelopmentVersion allButLast "remove 0 of minor version" ]
]

{ #category : #configuring }
PhLImageBisectCliCommand >> workingDirectory [
	
	| timestamp |
	timestamp := DateAndTime now printString copyUpTo: $+.
	^ (FileLocator temp / ('pl-bisect-' , timestamp)) asFileReference   
]
