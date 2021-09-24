"
I represent a Pharo (or other) virtual machine that can be used to run an image.

# Filesystem Location
For standard Pharo VMs, this is handled automatically and users should not have to be concerned about the details. However, the name of my executable's root folder must follow an exact pattern because this is how I am matched to images. My custom subclasses will have to know where and how to install their files. My executable is kept in the Launcher VM folder, in a root folder of the form `{prefix}{version}{architecture}`, where:
- {prefix} - Standard Pharo VMs have no prefix, which is available and used to distinguish custom images/VMs. For example, Gtoolkit uses 'gt-'.
- {version} - Standard Pharo VMs use the image version without dots e.g. '90' for Pharo 9.0. Custom classes can use any convention they wish, e.g. Gtoolkit keeps the dots e.g. '0.8.83' for Gtoolkit 0.8.83.
- {architecture} - one of #('x64', 'x86')

Three folder naming examples:
- 64-bit: For Pharo 9.0 64-bit, I would be in the `path/to/vms/90-x64` folder
- 32-bit: For Pharo 8.0 32-bit, I would be in the `path/to/vms/80-x86` folder
- Custom VM: For GToolkit 0.8.83, I would be in the `path/to/vms/gt-0.8.83-x64` folder

#Customized VM Types
Subclassing me allows you to use non-standard Pharo VMs, customizing things like the `#executableName`. Also, pick a prefix as described above in 'Filesystem Location'.

##Setup
Currently, custom VMs can't be downloaded via Launcher due to differences in URL and other conventions, although this could probably be implemented if someone was interested enough. To install VMs within Launcher
1. Download the VM
2. Put the VM, including all libraries and other needed resources - like the sources file - into a folder as described above in 'Filesystem Location'

executableRef is a reference to the script/binary to actually use to launch images.
vmBinaryRef is a reference to the vm binary (not a bash file).
"
Class {
	#name : #PhLVirtualMachine,
	#superclass : #Object,
	#instVars : [
		'executableRef',
		'vmBinaryRef',
		'name',
		'manager',
		'flavour',
		'id',
		'blessing',
		'arch'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #'instance creation' }
PhLVirtualMachine class >> directory: aFileReference [
	^ self 
		directory: aFileReference
		private: false
]

{ #category : #'instance creation' }
PhLVirtualMachine class >> directory: aFileReference private: isPrivateVm [
	| targetClass |
	targetClass := self allSubclasses detect: [ :cls | cls isSubclassForDirectory: aFileReference private: isPrivateVm ] ifNone: [ self ].
	^ targetClass new 
		initializeOn: aFileReference;
		yourself 
]

{ #category : #accessing }
PhLVirtualMachine class >> elfMagicNumber [
	^ ByteArray newFrom: #(127 69 76 70)
]

{ #category : #querying }
PhLVirtualMachine class >> executableName [
	^ PlatformResolver forCurrentPlatform vmExecutableName
]

{ #category : #accessing }
PhLVirtualMachine class >> headlessOptionString [
	^ '--headless'
]

{ #category : #'instance creation' }
PhLVirtualMachine class >> id: aString [

	^ self new
		id: aString;
		initializeExecutableRef;
		yourself
]

{ #category : #testing }
PhLVirtualMachine class >> isSubclassForDirectory: aFileReference private: isPrivateVm [

	^ isPrivateVm not and: [ aFileReference basename beginsWith: self versionPrefix ]
]

{ #category : #accessing }
PhLVirtualMachine class >> versionPrefix [
	"See class comment, 'Filesystem Location' section"

	^ ''
]

{ #category : #comparing }
PhLVirtualMachine >> = aVM [
	self class = aVM class 
		ifFalse: [ ^ false ]. 
	
	^ aVM id = self id
]

{ #category : #comparing }
PhLVirtualMachine >> > aPhLVirtualMachine [ 
	self pharoVersion = aPhLVirtualMachine pharoVersion
		ifTrue: [ ^ self is64bit ].
		
	^ self pharoVersion asNumber > aPhLVirtualMachine pharoVersion asNumber
]

{ #category : #querying }
PhLVirtualMachine >> archPath [
	^ self is64bit
		ifTrue: [ '64' ]
		ifFalse: [ '' ]
]

{ #category : #initialization }
PhLVirtualMachine >> basicInitializeOn: aFolder [
	id := aFolder basename.
]

{ #category : #initialization }
PhLVirtualMachine >> be64bits [
	arch := '64'
]

{ #category : #initialization }
PhLVirtualMachine >> beHeadless [

	"Set the flavour to attach to the vm download url"
	flavour := self headlessFlavour
]

{ #category : #initialization }
PhLVirtualMachine >> beLatest [
	blessing := 'latest'
]

{ #category : #accessing }
PhLVirtualMachine >> blessing [
	^ blessing
]

{ #category : #querying }
PhLVirtualMachine >> downloadUrl [
	^ (PhLVmProvider for: self) url
]

{ #category : #updating }
PhLVirtualMachine >> ensureExecutionRights [
	"Unzipping with Pharo does not preserve unix rights and so, the pahro VM executable does not have the execution permission.
	We have to set it explicitely on Unix and OS X."

	Smalltalk os isWindows ifTrue: [ ^ self ].

	PhLProcessWrapper new
		shellCommand;
		addArguments: 'chmod u+x';
		in: [ :command | self executablesToEnsure do: [ :file | command addArgument: file fullName surroundedByDoubleQuotes ] ];
		runAndWaitTimeOut: 5 seconds
]

{ #category : #setting }
PhLVirtualMachine >> executable: aPathOrfileReference [
	executableRef := aPathOrfileReference asFileLocatorOrReference
]

{ #category : #accessing }
PhLVirtualMachine >> executableFolderPath [
	^ self executableRef parent fullName
]

{ #category : #accessing }
PhLVirtualMachine >> executablePath [
	^ self executableRef fullName
]

{ #category : #accessing }
PhLVirtualMachine >> executableRef [ 
	^ executableRef asFileReference
]

{ #category : #accessing }
PhLVirtualMachine >> executablesToEnsure [
	| vmFolder |
	vmFolder := self vmStore / self id.
	^ vmFolder exists ifTrue: [ (vmFolder allChildrenMatching: self class executableName) select: #isFile ] ifFalse: [ #() ]
]

{ #category : #accessing }
PhLVirtualMachine >> flavour [
	^ flavour
]

{ #category : #comparing }
PhLVirtualMachine >> hash [

	^ self id hash
]

{ #category : #accessing }
PhLVirtualMachine >> headlessFlavour [
	^ '-headless'
]

{ #category : #accessing }
PhLVirtualMachine >> id [
	^ id
]

{ #category : #accessing }
PhLVirtualMachine >> id: aString [
	id := aString.
	(aString includesAll: '-x64')
		ifTrue: [ self be64bits ].
]

{ #category : #testing }
PhLVirtualMachine >> ifValid: aBlockClosure [ 
	self isValid
		ifTrue: [ aBlockClosure value ]
]

{ #category : #initialization }
PhLVirtualMachine >> initialize [
	super initialize.
	flavour := ''. "No flavour means heafull vm, it will be used to fetch the vm"
	blessing := 'stable'.
]

{ #category : #initialization }
PhLVirtualMachine >> initializeExecutableRef [
	
	executableRef ifNil: [ | vmFolder |
		vmFolder := self vmStore / self id.
		vmFolder exists ifTrue: [ self initializeExecutableRefFrom: vmFolder ] ]
]

{ #category : #initialization }
PhLVirtualMachine >> initializeExecutableRefFrom: aFolder [
	| executables vmFolder |
	vmFolder := aFolder asFileReference. "ensure we compare file references and not locators"
	executables := vmFolder allChildrenMatching: self class executableName.
	Smalltalk os isUnix
		ifTrue: [ "On linux, either the VM exe is at the top level or a bash script at the top level has to be used"
			executableRef := executables
				detect: [ :fileRef | fileRef parent = vmFolder ]
				ifNone: [ PhLExecutableNotFoundError signalKind: 'executable' inPath: vmFolder fullName ].
			vmBinaryRef := executables
				detect: [ :fileRef | fileRef binaryReadStreamDo: [ :stream | (stream next: 4) = self class elfMagicNumber ] ]
				ifNone: [ PhLExecutableNotFoundError signalKind: 'VM binary' inPath: vmFolder fullName ] ]
		ifFalse: [ executableRef := vmBinaryRef := executables 
			detect: #isFile 
			ifNone: [ PhLExecutableNotFoundError signalKind: 'executable' inPath: vmFolder fullName ] ].
	executableRef := executableRef asFileLocatorOrReference.
	vmBinaryRef := vmBinaryRef asFileLocatorOrReference.
]

{ #category : #initialization }
PhLVirtualMachine >> initializeOn: aFolder [
	self basicInitializeOn: aFolder.
	self initializeExecutableRefFrom: aFolder.
]

{ #category : #testing }
PhLVirtualMachine >> is64bit [
	^ arch
		ifNil: [ (self id last: 3) = 'x64' ] 
		ifNotNil: [ arch = '64' ]
	
]

{ #category : #testing }
PhLVirtualMachine >> isHeadless [ 
	^ flavour = self headlessFlavour
]

{ #category : #testing }
PhLVirtualMachine >> isPreSpur [
	^ id includes: 'preSpur'
]

{ #category : #testing }
PhLVirtualMachine >> isValid [
	^ self executableRef isNotNil
		and: [ self executableRef isFile
				and: [ self vmBinaryRef isNotNil ] ]
]

{ #category : #testing }
PhLVirtualMachine >> isValidAfterUpdate [
	self isValid ifTrue: [ ^ true ].
	
	self updateFromUrl.
	^ self isValid
]

{ #category : #querying }
PhLVirtualMachine >> lastUpdateTime [
	^ self executableRef modificationTime
]

{ #category : #querying }
PhLVirtualMachine >> lastUpdateTimeDescription [
	
	| timestamp |
	self isValid ifFalse: [ ^ 'Not available' ].
	timestamp := self lastUpdateTime.
	^ timestamp asDate yyyymmdd, ' ', timestamp asTime print24
]

{ #category : #updating }
PhLVirtualMachine >> manager [
	^ manager ifNil: [ manager := PhLVirtualMachineManager new ]
]

{ #category : #accessing }
PhLVirtualMachine >> manager: aPhLVirtualMachineManager [ 
	manager := aPhLVirtualMachineManager
]

{ #category : #accessing }
PhLVirtualMachine >> name [
	^ self id
]

{ #category : #querying }
PhLVirtualMachine >> pharoVersion [
	^ ($- split: self id) first
]

{ #category : #printing }
PhLVirtualMachine >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self id;
		nextPut: $)
]

{ #category : #actions }
PhLVirtualMachine >> removeFromSystem [
	| vmFolder zipFile |
	vmFolder := self vmStore / self name.
	vmFolder exists
		ifTrue: [ vmFolder ensureDeleteAll ].
	zipFile := self vmStore / (self name, '.zip').
	zipFile exists
		ifTrue: [ zipFile ensureDelete ].

]

{ #category : #actions }
PhLVirtualMachine >> showInFolder [
	PhLFileBrowser openOn: self vmStore / self id
]

{ #category : #'ston persistence' }
PhLVirtualMachine >> stonOn: stonWriter [
	stonWriter writeObject: self streamMap: [ :mapWriter |
		self class stonAllInstVarNames 
			do: [ :each | | value | 
				value := self stonValueOf: each.
				value ifNotNil: [ mapWriter at: each put: value ] ] ].
]

{ #category : #'ston persistence' }
PhLVirtualMachine >> stonValueOf: anInstVarName [
	anInstVarName = #executableRef 
		ifTrue: [ ^ executableRef ifNotNil: [ executableRef asFileLocatorOrReference ] ].
	anInstVarName = #vmBinaryRef 
		ifTrue: [ ^ vmBinaryRef ifNotNil: [ vmBinaryRef asFileLocatorOrReference ] ].
	^ self instVarNamed: anInstVarName
]

{ #category : #updating }
PhLVirtualMachine >> updateFromUrl [
	"fetch a new version of this Virtual Machine if available"

	self manager class fetch: self downloadUrl to: self vmStore / (self id , '.zip').

	self initializeExecutableRefFrom: self vmStore / self id.
	self ensureExecutionRights
]

{ #category : #accessing }
PhLVirtualMachine >> validityDescription [
	
	^ self isValid
		ifTrue: [ 'VM available' ]
		ifFalse: [ 'VM not available' ]
]

{ #category : #setting }
PhLVirtualMachine >> vmBinary: aPathOrFileReference [
	vmBinaryRef := aPathOrFileReference asFileReference
]

{ #category : #accessing }
PhLVirtualMachine >> vmBinaryRef [ 
	^ vmBinaryRef asFileReference
]

{ #category : #accessing }
PhLVirtualMachine >> vmFolder [
	^ self vmBinaryRef parent
]

{ #category : #accessing }
PhLVirtualMachine >> vmFolderPath [
	^ self vmFolder fullName
]

{ #category : #accessing }
PhLVirtualMachine >> vmStore [
	^ self manager vmStore
]
