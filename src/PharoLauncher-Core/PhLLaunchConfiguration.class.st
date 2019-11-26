"
I am a launch configuration that knows how to launch an image.
I have all the required information to run one:
 - vm
 - arguments
 - use settings
An image stores many of my instances so the user can choose one to launch it.
"
Class {
	#name : #PhLLaunchConfiguration,
	#superclass : #Object,
	#instVars : [
		'image',
		'name',
		'imageArguments',
		'usePharoSettings',
		'vm'
	],
	#classVars : [
		'LaunchInALoginShell'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLLaunchConfiguration class >> defaultWithImage: anImage [

	^ (self withImage: anImage)
		name: 'Default';
		yourself
]

{ #category : #settings }
PhLLaunchConfiguration class >> launchInALoginShell [
	^ LaunchInALoginShell ifNil: [ LaunchInALoginShell := true ]
]

{ #category : #settings }
PhLLaunchConfiguration class >> launchInALoginShell: aBoolean [
	LaunchInALoginShell := aBoolean
]

{ #category : #settings }
PhLLaunchConfiguration class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #launchInALoginShell)
		label: 'Launch image from a login shell' translated;
		parent: #pharoLauncher;
		target: self;
		order: 31;
		description: 'When enabled, Pharo Launcher will start a Shell and launch the image from it. ' , String cr , 'It allows to inherit from the Shell environment variables.'
]

{ #category : #'instance creation' }
PhLLaunchConfiguration class >> withImage: anImage [

	^ self new
		initializeWithImage: anImage;
		yourself
]

{ #category : #querying }
PhLLaunchConfiguration >> commandString [
	^ self launchProcess commandLineString
]

{ #category : #querying }
PhLLaunchConfiguration >> defaultVm [
	self image ensurePharoVersion.
	^ self image vmManager virtualMachine
]

{ #category : #configuring }
PhLLaunchConfiguration >> doNotUseSettings [
	"Cannot skip Pharo settings before Pharo 3.0"
	self image ensurePharoVersion >= '30'
		ifTrue: [ usePharoSettings := false ].

]

{ #category : #accessing }
PhLLaunchConfiguration >> image [
	^ image
]

{ #category : #initialization }
PhLLaunchConfiguration >> initializeWithImage: anImage [

	self initialize.
	image := anImage.
	name := 'new configuration...'.
	usePharoSettings := true.
	imageArguments := ''
]

{ #category : #accessing }
PhLLaunchConfiguration >> isUsingPharoSettings [
	^ usePharoSettings
]

{ #category : #querying }
PhLLaunchConfiguration >> launchProcess [
	self vm isValidAfterUpdate
		ifFalse: [ PhLMissingVirtualMachineError signalVm: self vm ].
	^ PhLImageProcessConfigurator new 
		vmPath: self vm executablePath;
		launchInALoginShell: self class launchInALoginShell;
		usePharoSettings: self isUsingPharoSettings;
		imageFile: image file;
		visit.
]

{ #category : #accessing }
PhLLaunchConfiguration >> name: aString [ 
	name := aString
]

{ #category : #accessing }
PhLLaunchConfiguration >> vm [
	^ vm ifNil: [ vm := self defaultVm ]

]
