"
I represent a Pharo image. I live in a particular location and have a name. Users can launch me.

Instance Variables
	file:		a reference to the .image file
	description: user description of the image
	formatNumber: image format number encoded in the image header
	architecture: is the image 32-bit or 64-bit
	pharoVersion: the Pharo version number of the image 
	originTemplate: template that was used to create this image
	
My metadata are serialized when setting description, template or before launching the image (implies to compute formatNumber, architecture and pharo version)
"
Class {
	#name : #PhLImage,
	#superclass : #PhLObject,
	#instVars : [
		'file',
		'description',
		'formatNumber',
		'architecture',
		'pharoVersion',
		'originTemplate'
	],
	#classVars : [
		'LaunchInALoginShell'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLImage class >> descriptionFileName [
	^ 'description.txt'
]

{ #category : #'instance creation' }
PhLImage class >> imageFromMetadata: imageFileReference [
	"Will recreate the image object from its STON serialized version if possible"
	(imageFileReference parent / self metadataFileName) 
		readStreamDo: [ :stream | | object |
			object := STON fromStream: stream.
			(object isKindOf: PhLImage)
				ifTrue: [ ^ object ]. 
			(object isKindOf: Dictionary)
				ifTrue: [ "old metadata file"
					^ self new 
						privOriginTemplate: (object at: #template);
						yourself ]. 
			PhLError signal: 'Unrecognized metadata format'  ]
		ifAbsent: [ ^ self new ].
	
]

{ #category : #settings }
PhLImage class >> launchInALoginShell [
	^ LaunchInALoginShell ifNil: [ LaunchInALoginShell := true ].
]

{ #category : #settings }
PhLImage class >> launchInALoginShell: aBoolean [
	LaunchInALoginShell := aBoolean
]

{ #category : #'instance creation' }
PhLImage class >> location: imageFileReference [
	^ (self imageFromMetadata: imageFileReference)
		setLocation: imageFileReference;
		yourself
]

{ #category : #accessing }
PhLImage class >> metadataFileName [
	^ 'meta-inf.ston'
]

{ #category : #settings }
PhLImage class >> settingsOn: aBuilder [
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
PhLImage class >> stonAllInstVarNames [
	^ super stonAllInstVarNames reject: [ :varName | varName = #file ]
]

{ #category : #accessing }
PhLImage >> architecture [
	^ architecture ifNil: [ self computeArchitecture. "Always be able to display image architecture" ]
]

{ #category : #accessing }
PhLImage >> changesFile [
	^ self file parent / self file basenameWithoutExtension , 'changes'
]

{ #category : #computing }
PhLImage >> computeArchitecture [
	self computeFormatNumber.
	((PhLVirtualMachineManager is32bits: formatNumber)
		or: [ PhLVirtualMachineManager isPreSpur: formatNumber ])
		ifTrue: [ ^ architecture := '32' ].
	(PhLVirtualMachineManager is64bits: formatNumber)
		ifTrue: [ ^ architecture :='64' ].
	^ architecture := 	'N/A'
]

{ #category : #computing }
PhLImage >> computeFormatNumber [
	formatNumber := PhLVirtualMachineManager imageFormatNumberFromFile: file
]

{ #category : #computing }
PhLImage >> computePharoVersionWith: vmManager [
	pharoVersion := vmManager imageVersion.
	self computeArchitecture.
	self serializeMetadata.
]

{ #category : #accessing }
PhLImage >> description [
	^ description ifNil: [ self descriptionFromFile ]
]

{ #category : #accessing }
PhLImage >> description: aString [
	description := aString.
	self serializeMetadata.
]

{ #category : #accessing }
PhLImage >> descriptionFromFile [
	| descriptionFile |
	descriptionFile := file parent / self class descriptionFileName.
	
	^ descriptionFile exists
		ifTrue: [ descriptionFile contents withNoLineLongerThan: 80 ]
		ifFalse: [ 'There is no description' ]
]

{ #category : #accessing }
PhLImage >> file [ 
	^file
]

{ #category : #accessing }
PhLImage >> formatNumber [
	^ formatNumber
]

{ #category : #testing }
PhLImage >> hasChildren [
	^ false
]

{ #category : #accessing }
PhLImage >> imageFile [
	^ self file
]

{ #category : #testing }
PhLImage >> isHighlighted [
	^ false
]

{ #category : #testing }
PhLImage >> isImage [
	^ true
]

{ #category : #accessing }
PhLImage >> lastModification [
	^ self file modificationTime
]

{ #category : #action }
PhLImage >> launchCommandStringWithSettings: usePharoSettings [
	^ (self launchProcessWithSettings: usePharoSettings) commandLineString

]

{ #category : #action }
PhLImage >> launchProcessWithSettings: usePharoSettings [
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: file.
	^ self launchProcessWithVmManager: vmManager useSettings: usePharoSettings.

]

{ #category : #action }
PhLImage >> launchProcessWithVm: vmPath useSettings: usePharoSettings [
	^ PhLImageProcessConfigurator new 
		vmPath: vmPath;
		launchInALoginShell: self class launchInALoginShell;
		usePharoSettings: usePharoSettings;
		imageFile: file;
		visit.
]

{ #category : #action }
PhLImage >> launchProcessWithVmManager: vmManager useSettings: usePharoSettings [
	| shouldUsePharoSettings |
	shouldUsePharoSettings := usePharoSettings.
	self computePharoVersionWith: vmManager.
	pharoVersion < '30'
		ifTrue: [ shouldUsePharoSettings := true ].	" Cannot skip Pharo settings before 3.0"
	^ self
		launchProcessWithVm: vmManager vm
		useSettings: shouldUsePharoSettings
]

{ #category : #action }
PhLImage >> launchWithSettings: usePharoSettings [
	| architectureWarningEnabled continue |
	architectureWarningEnabled := true.
	continue := true.
	[ [ ^ (self launchProcessWithSettings: usePharoSettings) runUnwatch ]
		on: PhLImageVersionDeterminationError
		do: [ :error |  error uiAlert ] ]
		on: PhLArchitectureMismatchWarning
		do: [ :warning | |  |
			(PhLLaunchImageCommand warnOnArchMismatch and: [ architectureWarningEnabled  ])
				ifTrue: [ 
					architectureWarningEnabled := false. "only raise one warning"
					continue := YesNoDialogWithTickBoxWindow confirm: warning longDescription label: warning name. ].
			continue ifTrue: [ warning resume ]. ]
]

{ #category : #accessing }
PhLImage >> name [
	^ file basenameWithoutExtension
]

{ #category : #accessing }
PhLImage >> originTemplate [

	^ originTemplate
]

{ #category : #accessing }
PhLImage >> originTemplate: aPhLTemplate [
	
	self privOriginTemplate: aPhLTemplate.
	self serializeMetadata.
]

{ #category : #accessing }
PhLImage >> originTemplateName [

	^ self originTemplate 
		ifNotNil: [ :template | template name ] 
		ifNil: [ #unknown ]
]

{ #category : #accessing }
PhLImage >> pharoVersion [
	^ pharoVersion ifNil: [ self pharoVersionFromFile ]
]

{ #category : #accessing }
PhLImage >> pharoVersionFromFile [
	file ifNil: [ ^ '' ].
	^ self versionFile exists
		ifTrue: [ pharoVersion := self versionFile contents ]
		ifFalse: [ '' ]
]

{ #category : #printing }
PhLImage >> printOn: aStream [
	aStream
		nextPutAll: 'Image (';
		nextPutAll: self name;
		nextPutAll: ')'
]

{ #category : #accessing }
PhLImage >> privOriginTemplate: aPhLTemplate [
	
	originTemplate := aPhLTemplate.
]

{ #category : #serialization }
PhLImage >> serializeMetadata [

	(file parent / self class metadataFileName)
		writeStreamDo: [ :stream | stream nextPutAll: self stonString ]
]

{ #category : #'initialize-release' }
PhLImage >> setLocation: aFile [ 
	file := aFile.
]

{ #category : #printing }
PhLImage >> showNativeFolder [
	PhLFileBrowser openOn: file
]

{ #category : #accessing }
PhLImage >> sourcesFile [
	^ self file parent files 
		detect: [ :fileRef | fileRef extension = 'sources' ]
]

{ #category : #serialization }
PhLImage >> stonString [
	^ STON toStringPretty: self
]

{ #category : #printing }
PhLImage >> summaryInfo [
	^ String
		streamContents: [ :s | 
			s nextPutAll: 'Last modified: '.
			self file modificationTime printOn: s.
			s
				cr;
				nextPutAll: self file parent fullName;
				cr;
				cr;
				nextPutAll: self description ]
]

{ #category : #accessing }
PhLImage >> versionFile [
	^ self file parent / PhLVirtualMachineManager imageVersionFileName
]

{ #category : #action }
PhLImage >> vm [
	^ (PhLVirtualMachineManager forImage: file pathString) vmFileName
]
