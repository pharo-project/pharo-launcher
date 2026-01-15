"
I'm a launch configuration generated automatically when no Launch Configuration has been defined for an image.

When a value is changed, I'm converted to a classic PhLLaunchConfiguration.
"
Class {
	#name : 'PhLDefaultLaunchConfiguration',
	#superclass : 'Object',
	#instVars : [
		'name',
		'workingDirectory',
		'vmArguments',
		'image',
		'imageArguments',
		'usePharoSettings',
		'vm'
	],
	#classVars : [
		'LaunchInALoginShell'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLDefaultLaunchConfiguration class >> defaultName [
	^ 'Default'
]

{ #category : 'settings' }
PhLDefaultLaunchConfiguration class >> launchInALoginShell [
	^ LaunchInALoginShell ifNil: [ LaunchInALoginShell := true ]
]

{ #category : 'settings' }
PhLDefaultLaunchConfiguration class >> launchInALoginShell: aBoolean [
	LaunchInALoginShell := aBoolean
]

{ #category : 'settings' }
PhLDefaultLaunchConfiguration class >> settingsOn: aBuilder [

	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #launchInALoginShell)
		label: 'Launch image from a login shell' translated;
		groupName: #pharoLauncher;
		target: self;
		order: 31;
		description:
			'When enabled, Pharo Launcher will start a Shell and launch the image from it. '
			, String cr
			, 'It allows to inherit from the Shell environment variables.'
]

{ #category : 'instance creation' }
PhLDefaultLaunchConfiguration class >> withImage: anImage [

	^ self new
		initializeWithImage: anImage;
		yourself
]

{ #category : 'comparing' }
PhLDefaultLaunchConfiguration >> = anObject [

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	^ self name = anObject name
]

{ #category : 'converting' }
PhLDefaultLaunchConfiguration >> asLaunchConfiguration [

	^ (PhLLaunchConfiguration withImage: self image)
			name: self name;
			yourself
]

{ #category : 'testing' }
PhLDefaultLaunchConfiguration >> canBeLaunched [
	
	self vm isValidAfterUpdate ifFalse: [ ^ false ].
	self vm isValidForArchitecture ifFalse: [ ^ false ].
	^ true
]

{ #category : 'querying' }
PhLDefaultLaunchConfiguration >> commandString [
	^ self launchProcess commandLineString
]

{ #category : 'querying' }
PhLDefaultLaunchConfiguration >> defaultVm [
	self image ensurePharoVersion.
	^ self image vmManager virtualMachine
]

{ #category : 'configuring' }
PhLDefaultLaunchConfiguration >> doNotUseSettings [
	self useSettings: false
]

{ #category : 'comparing' }
PhLDefaultLaunchConfiguration >> hash [ 
	^ self name hash
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> image [
	^ image
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> imageArguments [
	^ imageArguments ifNil: [ OrderedCollection new ]
]

{ #category : 'initialization' }
PhLDefaultLaunchConfiguration >> initializeWithImage: anImage [

	self initialize.
	image := anImage.
	name := self class defaultName.
	usePharoSettings := true.
	imageArguments := anImage defaultArguments
]

{ #category : 'testing' }
PhLDefaultLaunchConfiguration >> isDefault [

	^ true
]

{ #category : 'testing' }
PhLDefaultLaunchConfiguration >> isNullConfiguration [
	^ false
]

{ #category : 'testing' }
PhLDefaultLaunchConfiguration >> isUsingPharoSettings [
	^ usePharoSettings ifNil: [ usePharoSettings := true ]
]

{ #category : 'querying' }
PhLDefaultLaunchConfiguration >> launchProcess [
	self vm isValidAfterUpdate
		ifFalse: [ PhLMissingVirtualMachineError signalVm: self vm ].
	^ PhLLaunchImageProcessConfigurator new 
		launchConfiguration: self;
		visit.
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> name [
	^ name
]

{ #category : 'printing' }
PhLDefaultLaunchConfiguration >> printOn: aStream [
	aStream << self class name << '(' << self name << ')'
]

{ #category : 'private' }
PhLDefaultLaunchConfiguration >> setVm: aPhLVirtualMachine [ 
	vm := aPhLVirtualMachine.
	vm manager: self image vmManager.
]

{ #category : 'configuring' }
PhLDefaultLaunchConfiguration >> useSettings: aBoolean [
	"Cannot skip Pharo settings before Pharo 3.0"
	self image ensurePharoVersion asInteger < 30 ifTrue: [ ^ self ].

	usePharoSettings := aBoolean.
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> vm [
	^ vm ifNil: [ self setVm: self defaultVm. vm ]

]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> vmArguments [
	^ vmArguments ifNil: [ OrderedCollection new ]
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> workingDirectory [

	^ workingDirectory ifNil: [ image imageFile parent ]
]
