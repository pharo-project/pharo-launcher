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

{ #category : #serialization }
PhLLaunchConfiguration class >> stonAllInstVarNames [
	^ super stonAllInstVarNames reject: [ :varName | varName = #usePharoSettings ]
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
	self useSettings: false
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
	^ imageArguments ifNil: [ OrderedCollection new ]
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
	imageArguments := anImage defaultArguments.
]

{ #category : #testing }
PhLLaunchConfiguration >> isNullConfiguration [
	^ false
]

{ #category : #testing }
PhLLaunchConfiguration >> isUsingPharoSettings [
	^ usePharoSettings ifNil: [ usePharoSettings := true ]
]

{ #category : #querying }
PhLLaunchConfiguration >> launchProcess [
	self vm isValidAfterUpdate
		ifFalse: [ PhLMissingVirtualMachineError signalVm: self vm ].
	^ PhLLaunchImageProcessConfigurator new 
		launchConfiguration: self;
		launchInALoginShell: self class launchInALoginShell;
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

{ #category : #printing }
PhLLaunchConfiguration >> printOn: aStream [
	aStream << self class name << '(' << self name << ')'
]

{ #category : #configuring }
PhLLaunchConfiguration >> useSettings: aBoolean [
	"Cannot skip Pharo settings before Pharo 3.0"
	self image ensurePharoVersion asInteger < 30 ifTrue: [ ^ self ].

	usePharoSettings := aBoolean.
]

{ #category : #accessing }
PhLLaunchConfiguration >> vm [
	^ vm ifNil: [ self vm: self defaultVm. vm ]

]

{ #category : #accessing }
PhLLaunchConfiguration >> vm: aPhLVirtualMachine [ 
	vm := aPhLVirtualMachine.
	vm manager: self image vmManager.
]

{ #category : #accessing }
PhLLaunchConfiguration >> vmArguments [
	^ vmArguments ifNil: [ OrderedCollection new ]
]

{ #category : #accessing }
PhLLaunchConfiguration >> vmArguments: aCollection [ 
	vmArguments := aCollection
]
