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
	#name : 'PhLVirtualMachine',
	#superclass : 'Object',
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
	#category : 'PharoLauncher-Core-Download',
	#package : 'PharoLauncher-Core',
	#tag : 'Download'
}

{ #category : 'instance creation' }
PhLVirtualMachine class >> directory: aFileReference [

	| targetClass |
	targetClass := self allSubclasses
		               detect: [ :cls | cls isSubclassForDirectory: aFileReference ]
		               ifNone: [ self ].
	^ targetClass new
		  initializeOn: aFileReference;
		  yourself
]

{ #category : 'accessing' }
PhLVirtualMachine class >> elfMagicNumber [
	^ ByteArray newFrom: #(127 69 76 70)
]

{ #category : 'querying' }
PhLVirtualMachine class >> executableName [
	^ PlatformResolver forCurrentPlatform vmExecutableName
]

{ #category : 'accessing' }
PhLVirtualMachine class >> headlessOptionString [
	^ '--headless'
]

{ #category : 'instance creation' }
PhLVirtualMachine class >> id: aString [

	^ self new
		id: aString;
		initializeExecutableRef;
		yourself
]

{ #category : 'testing' }
PhLVirtualMachine class >> isSubclassForDirectory: aFileReference [

	^ aFileReference basename beginsWith: self versionPrefix
]

{ #category : 'updating' }
PhLVirtualMachine class >> updateAll: virtualMachines [
	"A VM failing to update is left as it was: the other VMs are still updated.
	Answer the errors telling which VMs were not updated."

	| errors |
	errors := OrderedCollection new.
	virtualMachines do: [ :each |
		[ each updateFromUrl ]
			on: Error
			do: [ :error | errors add: (PhLVirtualMachineUpdateError vm: each cause: error) ] ].
	^ errors
]

{ #category : 'accessing' }
PhLVirtualMachine class >> versionPrefix [
	"See class comment, 'Filesystem Location' section"

	^ ''
]

{ #category : 'comparing' }
PhLVirtualMachine >> = aVM [
	self class = aVM class 
		ifFalse: [ ^ false ]. 
	
	^ aVM id = self id
]

{ #category : 'comparing' }
PhLVirtualMachine >> > aPhLVirtualMachine [ 
	self pharoVersion = aPhLVirtualMachine pharoVersion
		ifTrue: [ ^ self is64bit ].
		
	^ self pharoVersion asNumber > aPhLVirtualMachine pharoVersion asNumber
]

{ #category : 'querying' }
PhLVirtualMachine >> archPath [
	^ self is64bit
		ifTrue: [ '64' ]
		ifFalse: [ '' ]
]

{ #category : 'initialization' }
PhLVirtualMachine >> basicInitializeOn: aFolder [
	id := aFolder basename.
]

{ #category : 'initialization' }
PhLVirtualMachine >> be64bits [
	arch := '64'
]

{ #category : 'initialization' }
PhLVirtualMachine >> beHeadless [

	"Set the flavour to attach to the vm download url"
	flavour := self headlessFlavour
]

{ #category : 'initialization' }
PhLVirtualMachine >> beLatest [
	blessing := 'latest'
]

{ #category : 'accessing' }
PhLVirtualMachine >> blessing [
	^ blessing
]

{ #category : 'querying' }
PhLVirtualMachine >> downloadUrl [
	^ (PhLVmProvider for: self) url
]

{ #category : 'updating' }
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

{ #category : 'setting' }
PhLVirtualMachine >> executable: aPathOrfileReference [
	executableRef := aPathOrfileReference asFileLocatorOrReference
]

{ #category : 'accessing' }
PhLVirtualMachine >> executableFolderPath [
	^ executableRef parent fullName
]

{ #category : 'accessing' }
PhLVirtualMachine >> executablePath [
	^ executableRef fullName
]

{ #category : 'accessing' }
PhLVirtualMachine >> executablesToEnsure [
	| vmFolder |
	vmFolder := self vmStore / self id.
	^ vmFolder exists ifTrue: [ (vmFolder allChildrenMatching: self class executableName) select: #isFile ] ifFalse: [ #() ]
]

{ #category : 'accessing' }
PhLVirtualMachine >> flavour [
	^ flavour
]

{ #category : 'ston persistence' }
PhLVirtualMachine >> fromSton: stonReader [
	super fromSton: stonReader.
	
	executableRef isString ifTrue: [ executableRef := executableRef asFileLocatorOrReference ].
	vmBinaryRef isString ifTrue: [ vmBinaryRef := vmBinaryRef asFileLocatorOrReference ].
]

{ #category : 'comparing' }
PhLVirtualMachine >> hash [

	^ self id hash
]

{ #category : 'accessing' }
PhLVirtualMachine >> headlessFlavour [
	^ '-headless'
]

{ #category : 'accessing' }
PhLVirtualMachine >> id [
	^ id
]

{ #category : 'accessing' }
PhLVirtualMachine >> id: aString [
	id := aString.
	(aString includesAll: '-x64')
		ifTrue: [ self be64bits ].
]

{ #category : 'testing' }
PhLVirtualMachine >> ifValid: aBlockClosure [ 
	self isValid
		ifTrue: [ aBlockClosure value ]
]

{ #category : 'initialization' }
PhLVirtualMachine >> initialize [
	super initialize.
	flavour := ''. "No flavour means heafull vm, it will be used to fetch the vm"
	blessing := 'stable'.
]

{ #category : 'initialization' }
PhLVirtualMachine >> initializeExecutableRef [
	
	executableRef ifNil: [ | vmFolder |
		vmFolder := self vmStore / self id.
		vmFolder exists ifTrue: [ self initializeExecutableRefFrom: vmFolder ] ]
]

{ #category : 'initialization' }
PhLVirtualMachine >> initializeExecutableRefFrom: aFolder [
	| executables vmFolder |
	vmFolder := aFolder asFileReference. "ensure we compare file references and not locators"
	executables := vmFolder allChildrenMatching: self class executableName.
	OSPlatform current isUnix
		ifTrue: [ "On linux, either the VM exe is at the top level or a bash script at the top level has to be used"
			executableRef := executables
				detect: [ :fileRef | fileRef parent = vmFolder ]
				ifNone: [ nil ].
			vmBinaryRef := executables
				detect: [ :fileRef | fileRef binaryReadStreamDo: [ :stream | (stream next: 4) = self class elfMagicNumber ] ]
				ifNone: [ nil ] ]
		ifFalse: [ executableRef := vmBinaryRef := executables 
			detect: #isFile 
			ifNone: [ nil ] ].
	executableRef := executableRef ifNotNil: [ :exe | exe asFileLocatorOrReference ].
	vmBinaryRef := vmBinaryRef  ifNotNil: [ :bin | bin asFileLocatorOrReference ].
]

{ #category : 'initialization' }
PhLVirtualMachine >> initializeOn: aFolder [
	self basicInitializeOn: aFolder.
	self initializeExecutableRefFrom: aFolder.
]

{ #category : 'querying' }
PhLVirtualMachine >> installationDate [
	"Answer the date I was installed or updated by the Launcher, nil if I am not installed.
	Before the Launcher stored it, the best guess is the date of my executable."

	self isValid ifFalse: [ ^ nil ].
	^ (self metadata installedOn ifNil: [ self lastUpdateTime ]) asDate
]

{ #category : 'updating' }
PhLVirtualMachine >> checkForUpdate [
	"Ask the server the stamp of the archive it publishes and record it in my folder, with my version, in one write.
	When the server does not answer, the result of the previous check is kept.
	Answer whether an update is available."

	| version stamp |
	self isValid ifFalse: [ ^ false ].
	"Running my executable and asking the server take time: done before writing my metadata"
	version := self readVersionIfChanged.
	stamp := self isUpdatable ifTrue: [ self fetchPublishedStamp ].
	self updateMetadata: [ :metadata |
		| hasChanged |
		hasChanged := self record: version in: metadata.
		stamp ifNotNil: [
			metadata recordCheck: stamp.
			hasChanged := true ].
		hasChanged ].
	^ self isUpdateAvailable
]

{ #category : 'updating' }
PhLVirtualMachine >> refreshVersion [
	"Record my version in my folder when my executable changed since it was recorded. The server is not asked."

	| version |
	self isValid ifFalse: [ ^ self ].
	version := self readVersionIfChanged.
	self updateMetadata: [ :metadata | self record: version in: metadata ]
]

{ #category : 'private' }
PhLVirtualMachine >> readVersionIfChanged [
	"Answer an association from the modification time of my executable to the version it prints, nil if this version is already recorded"

	| executableTime |
	executableTime := self lastUpdateTime.
	(self metadata versionOfExecutableModifiedOn: executableTime) ifNotNil: [ ^ nil ].
	^ executableTime -> self versionFromExecutable
]

{ #category : 'private' }
PhLVirtualMachine >> record: aVersion in: aMetadata [
	"Answer whether the metadata changed. The version may have been recorded meanwhile by another process."

	aVersion ifNil: [ ^ false ].
	(aMetadata versionOfExecutableModifiedOn: aVersion key) ifNotNil: [ ^ false ].
	aMetadata recordVersion: aVersion value executableTime: aVersion key.
	^ true
]

{ #category : 'private' }
PhLVirtualMachine >> updateMetadata: aBlock [
	"Read my metadata, let the block change it, and store it when the block answers true, without another process writing it meanwhile.
	Checks and installations are the only writers of my metadata: the VM manager and the command line only read it."

	self isValid ifFalse: [ ^ self ].
	PhLVmMetadata critical: [
		| metadata |
		metadata := self metadata.
		(aBlock value: metadata) ifTrue: [ metadata storeInFolder: self vmStore / self id ] ]
]

{ #category : 'private' }
PhLVirtualMachine >> fetchPublishedStamp [
	"Answer the stamp of the archive currently published on the server, nil if the server does not answer."

	^ [ PhLDownloadManager default stampOf: self downloadUrl ]
		  on: PhLDownloadError
		  do: [ nil ]
]

{ #category : 'querying' }
PhLVirtualMachine >> installedStamp [
	"Answer the stamp of the archive I was installed from, nil if unknown."

	^ self metadata installedStamp
]

{ #category : 'testing' }
PhLVirtualMachine >> is64bit [
	^ arch
		ifNil: [ (self id last: 3) = 'x64' ] 
		ifNotNil: [ arch = '64' ]
	
]

{ #category : 'testing' }
PhLVirtualMachine >> isHeadless [ 
	^ flavour = self headlessFlavour
]

{ #category : 'testing' }
PhLVirtualMachine >> isOutdatedBy: aPublishedStamp [
	"Answer whether the given stamp is the one of another archive than the one I was installed from.
	When the stamp of the archive I was installed from is unknown, rely on the date of my executable."

	self isUpdatable ifFalse: [ ^ false ].
	^ self installedStamp
		  ifNil: [ aPublishedStamp isNewerThan: self lastUpdateTime ]
		  ifNotNil: [ :installedStamp | (installedStamp isSameFileAs: aPublishedStamp) not ]
]

{ #category : 'testing' }
PhLVirtualMachine >> isPreSpur [
	^ id includes: 'preSpur'
]

{ #category : 'testing' }
PhLVirtualMachine >> isStandard [
	"Answer whether I am a VM published on the Pharo files server, as opposed to a custom VM the user put in the VM store.
	The download URL of a custom VM is the one of the standard VM for its Pharo version."

	^ id matchesRegex: '\d+(-preSpur)?-x(64|86)'
]

{ #category : 'testing' }
PhLVirtualMachine >> isUpdatable [
	"Answer whether an archive published on the server can tell if I am outdated."

	^ self isValid and: [ self isStandard ]
]

{ #category : 'testing' }
PhLVirtualMachine >> isUpdateAvailable [
	"Answer whether the last check found another archive than the one I was installed from. The server is not asked."

	self isUpdatable ifFalse: [ ^ false ].
	^ self publishedStamp
		  ifNil: [ false ]
		  ifNotNil: [ :stamp | self isOutdatedBy: stamp ]
]

{ #category : 'testing' }
PhLVirtualMachine >> isValid [
	^ executableRef isNotNil
		and: [ executableRef asFileReference isFile
				and: [ vmBinaryRef isNotNil ] ]
]

{ #category : 'testing' }
PhLVirtualMachine >> isValidAfterUpdate [
	self isValid ifTrue: [ ^ true ].
	
	self updateFromUrl.
	^ self isValid
]

{ #category : 'testing' }
PhLVirtualMachine >> isValidForArchitecture [
	vmBinaryRef ifNil: [ ^ false ].
	^ OSPlatform current isValid: self
]

{ #category : 'querying' }
PhLVirtualMachine >> lastUpdateTime [
	^ executableRef modificationTime
]

{ #category : 'querying' }
PhLVirtualMachine >> metadata [
	"Answer what the Launcher stored about me in my folder"

	^ PhLVmMetadata inFolder: self vmStore / self id
]

{ #category : 'testing' }
PhLVirtualMachine >> needsUpdate [
	"Answer whether I should be downloaded: I am not installed, or the server publishes an update."

	^ self isValid not or: [ self checkForUpdate ]
]

{ #category : 'accessing' }
PhLVirtualMachine >> location [
	"Answer the path of my folder in the VM store"

	^ (self vmStore / self id) fullName
]

{ #category : 'updating' }
PhLVirtualMachine >> manager [
	^ manager ifNil: [ manager := PhLVirtualMachineManager new ]
]

{ #category : 'accessing' }
PhLVirtualMachine >> manager: aPhLVirtualMachineManager [ 
	manager := aPhLVirtualMachineManager
]

{ #category : 'accessing' }
PhLVirtualMachine >> name [
	^ self id
]

{ #category : 'querying' }
PhLVirtualMachine >> pharoVersion [
	^ ($- split: self id) first
]

{ #category : 'printing' }
PhLVirtualMachine >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self id;
		nextPut: $)
]

{ #category : 'querying' }
PhLVirtualMachine >> publishedStamp [
	"Answer the stamp of the archive published on the server at the last check, nil if never checked."

	^ self metadata publishedStamp
]

{ #category : 'actions' }
PhLVirtualMachine >> removeFromSystem [
	| vmFolder zipFile |
	vmFolder := self vmStore / self name.
	vmFolder exists
		ifTrue: [ vmFolder ensureDeleteAll ].
	zipFile := self vmStore / (self name, '.zip').
	zipFile exists
		ifTrue: [ zipFile ensureDelete ].

]

{ #category : 'querying' }
PhLVirtualMachine >> status [
	"Answer whether I am up to date, in words, from the last check. The server is not asked."

	self isValid ifFalse: [ ^ 'Not installed' ].
	self isStandard ifFalse: [ ^ 'Custom VM' ].
	self publishedStamp ifNil: [ ^ 'Not checked' ].
	^ self isUpdateAvailable
		  ifTrue: [ 'Update available' ]
		  ifFalse: [ 'Up to date' ]
]

{ #category : 'actions' }
PhLVirtualMachine >> showInFolder [
	(self vmStore / self id) asFileReference openInOSFileBrowser 
]

{ #category : 'ston persistence' }
PhLVirtualMachine >> stonOn: stonWriter [
	stonWriter writeObject: self streamMap: [ :mapWriter |
		self class stonAllInstVarNames 
			do: [ :each | | value | 
				value := self stonValueOf: each.
				value ifNotNil: [ mapWriter at: each put: value ] ] ].
]

{ #category : 'ston persistence' }
PhLVirtualMachine >> stonValueOf: anInstVarName [
	anInstVarName = #executableRef 
		ifTrue: [ ^ executableRef ifNotNil: [ executableRef asFileLocatorOrReference ] ].
	anInstVarName = #vmBinaryRef 
		ifTrue: [ ^ vmBinaryRef ifNotNil: [ vmBinaryRef asFileLocatorOrReference ] ].
	^ self instVarNamed: anInstVarName
]

{ #category : 'updating' }
PhLVirtualMachine >> updateFromUrl [
	"fetch a new version of this Virtual Machine if available"

	self manager class 
		fetch: self downloadUrl 
		to: self vmStore / (self id , '.zip').

	self initializeExecutableRefFrom: self vmStore / self id.
	self ensureExecutionRights.
	self refreshVersion
]

{ #category : 'accessing' }
PhLVirtualMachine >> validityDescription [
	
	^ self isValid
		ifTrue: [ 'VM available' ]
		ifFalse: [ 'VM not available' ]
]

{ #category : 'querying' }
PhLVirtualMachine >> version [
	"Answer my version, e.g. '10.3.12': the recorded one, else the one printed by my executable (not recorded).
	Answer an empty string when it cannot be told, e.g. I am not installed or my executable cannot be run on this computer."

	self isValid ifFalse: [ ^ '' ].
	^ self recordedVersion ifNil: [ self versionFromExecutable ]
]

{ #category : 'private' }
PhLVirtualMachine >> recordedVersion [
	"Answer the version recorded for my executable as it is now, nil if none"

	^ self metadata versionOfExecutableModifiedOn: self lastUpdateTime
]

{ #category : 'querying' }
PhLVirtualMachine >> storedVersion [
	"Answer the version recorded by the last check or installation, an empty string if none. My executable is not run."

	self isValid ifFalse: [ ^ '' ].
	^ self recordedVersion ifNil: [ '' ]
]

{ #category : 'private' }
PhLVirtualMachine >> versionFromExecutable [

	| words version |
	words := self versionOutput substrings.
	words size < 2 ifTrue: [ ^ '' ].
	version := words second.
	(version beginsWith: 'v') ifTrue: [ version := version allButFirst ].
	^ (version notEmpty and: [ version first isDigit ])
		  ifTrue: [ version ]
		  ifFalse: [ '' ]
]

{ #category : 'private' }
PhLVirtualMachine >> versionOutput [
	"The version is the second word printed by the executable:
	'Pharo v10.3.12 built on ...', 'Pharo 9.0.22 built on ...' or '5.0 5.0.202002121007 Mac OS X built on ...'"

	^ PhLProcessWrapper outputOfShellCommand:
		  ('"{1}" --version 2> /dev/null' format: { self executablePath })
]

{ #category : 'setting' }
PhLVirtualMachine >> vmBinary: aPathOrFileReference [
	vmBinaryRef := aPathOrFileReference asFileReference
]

{ #category : 'setting' }
PhLVirtualMachine >> vmBinaryFullName [
	^ vmBinaryRef fullName
]

{ #category : 'accessing' }
PhLVirtualMachine >> vmFolder [
	^ vmBinaryRef parent
]

{ #category : 'accessing' }
PhLVirtualMachine >> vmFolderPath [
	^ self vmFolder fullName
]

{ #category : 'accessing' }
PhLVirtualMachine >> vmStore [
	^ self manager vmStore
]
