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
		'vm',
		'vmArguments'
	],
	#classVars : [
		'LaunchInALoginShell'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLLaunchConfiguration class >> defaultName [
	^ 'Default'
]

{ #category : #'instance creation' }
PhLLaunchConfiguration class >> defaultWithImage: anImage [

	^ (self withImage: anImage)
		name: self defaultName;
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

{ #category : #comparing }
PhLLaunchConfiguration >> = anObject [

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	^ self name = anObject name
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

{ #category : #comparing }
PhLLaunchConfiguration >> hash [ 
	^ self name hash
]

{ #category : #accessing }
PhLLaunchConfiguration >> image [
	^ image
]

{ #category : #accessing }
PhLLaunchConfiguration >> imageArguments [
	^ imageArguments
]

{ #category : #accessing }
PhLLaunchConfiguration >> imageArguments: aCollection [ 
	imageArguments := aCollection
]

{ #category : #initialization }
PhLLaunchConfiguration >> initializeWithImage: anImage [

	self initialize.
	image := anImage.
	name := 'new configuration...'.
	usePharoSettings := true.
	imageArguments := OrderedCollection new.
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
PhLLaunchConfiguration >> name [
	^ name
]

{ #category : #accessing }
PhLLaunchConfiguration >> name: aString [ 
	name := aString
]

{ #category : #accessing }
PhLLaunchConfiguration >> vm [
	^ vm ifNil: [ vm := self defaultVm ]

]

{ #category : #accessing }
PhLLaunchConfiguration >> vm: aPhLVirtualMachine [ 
	vm := aPhLVirtualMachine
]

{ #category : #accessing }
PhLLaunchConfiguration >> vmArguments [
	^ OrderedCollection new
]

{ #category : #accessing }
PhLLaunchConfiguration >> vmArguments: aCollection [ 
	vmArguments := aCollection
]
