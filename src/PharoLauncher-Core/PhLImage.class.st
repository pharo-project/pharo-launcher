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
		'originTemplate',
		'vmManager',
		'launchConfigurations',
		'initializationScript',
		'shouldRunInitializationScript'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLImage class >> descriptionFileName [
	^ 'description.txt'
]

{ #category : #example }
PhLImage class >> example [
	| fsRoot imageFile |
	fsRoot := FileSystem memory root.
	imageFile := fsRoot / 'foo64.image'.
	imageFile binaryWriteStreamDo: 
		[ :stream | 
		(ZnEndianessReadWriteStream on: stream ) nextLittleEndianNumber: 4 put: PhLVirtualMachineManager imageFormat64bits ].
	^ self location: imageFile
]

{ #category : #example }
PhLImage class >> example32 [
	| fsRoot imageFile |
	fsRoot := FileSystem memory root.
	imageFile := fsRoot / 'foo32.image'.
	imageFile binaryWriteStreamDo: 
		[ :stream | 
		(ZnEndianessReadWriteStream on: stream ) nextLittleEndianNumber: 4 put: PhLVirtualMachineManager imageFormat32bits ].
	^ self location: imageFile
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
				ifTrue: [ "old metadata file format"
					^ self new 
						privOriginTemplate: (object at: #template);
						yourself ]. 
			PhLError signal: 'Unrecognized metadata format'  ]
		ifAbsent: [ ^ self new ].
	
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

{ #category : #serialization }
PhLImage class >> stonAllInstVarNames [
	^ super stonAllInstVarNames reject: [ :varName | varName = #file ]
]

{ #category : #accessing }
PhLImage class >> versionFileName [
	^ 'pharo.version'
]

{ #category : #configuring }
PhLImage >> addLaunchConfiguration: aPhLLaunchConfiguration [
	launchConfigurations 
		detect: [ :each | each name = aPhLLaunchConfiguration name ]
		ifFound: [ PhLError signal: 'Cannot add configuration! A configuration with the same name already exists.' ]
		ifNone: [ launchConfigurations add: aPhLLaunchConfiguration ]
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
PhLImage >> computePharoVersion [
	pharoVersion := self vmManager imageVersion.
	self computeArchitecture.
	self serializeMetadata.
	^ pharoVersion
]

{ #category : #accessing }
PhLImage >> defaultLaunchConfiguration [
	^ launchConfigurations 
		detect: [ :each | each name = PhLLaunchConfiguration defaultName ]
		ifNone: [ PhLLaunchConfiguration defaultWithImage: self ]
]

{ #category : #accessing }
PhLImage >> defaultLaunchConfigurationName [
	^ 'Default'
]

{ #category : #accessing }
PhLImage >> description [
	^ description ifNil: [ self descriptionFromFile ]
]

{ #category : #accessing }
PhLImage >> description: aString [
	description := aString ifNotNil: #asString. "ensure we do not get Text"
	self serializeMetadata.
]

{ #category : #accessing }
PhLImage >> descriptionFromFile [
	| descriptionFile |
	self flag: 'This method is there for backward compatibility. description.txt file has been superseded by the metainformation file meta-inf.ston'.
	descriptionFile := file parent / self class descriptionFileName.
	
	^ descriptionFile exists
		ifTrue: [ descriptionFile contents withNoLineLongerThan: 80 ]
		ifFalse: [ 'There is no description' ]
]

{ #category : #configuring }
PhLImage >> doNotRunInitializationScript [
	self shouldRunInitializationScript: false.
]

{ #category : #computing }
PhLImage >> ensurePharoVersion [
	(self pharoVersion isNil or: [ self pharoVersion = '' ])
		ifFalse: [ self vmManager imageVersion: self pharoVersion.
					^ self pharoVersion ].
	^ self computePharoVersion.
	
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

{ #category : #accessing }
PhLImage >> initializationScript [
	^ initializationScript ifNotNil: [ :script | script asFileReference ]
]

{ #category : #accessing }
PhLImage >> initializationScript: aFileReference [
	initializationScript := aFileReference.
	self serializeMetadata
]

{ #category : #'initialize-release' }
PhLImage >> initialize [
	launchConfigurations := OrderedCollection new.
	shouldRunInitializationScript := true.
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
PhLImage >> launch [
	^ self launchWithConfiguration: self defaultLaunchConfiguration 
]

{ #category : #accessing }
PhLImage >> launchConfigurations [
	^ launchConfigurations
		ifEmpty: [ launchConfigurations 
						add: self defaultLaunchConfiguration;
						yourself ]
]

{ #category : #accessing }
PhLImage >> launchConfigurations: aCollection [ 
	launchConfigurations := aCollection
]

{ #category : #action }
PhLImage >> launchWithConfiguration: aPhLLaunchConfiguration [
	| architectureWarningEnabled continue |
	architectureWarningEnabled := true.
	continue := true.
	[ [ | processWrapper|
		processWrapper := (aPhLLaunchConfiguration launchProcess) runUnwatch.
		self doNotRunInitializationScript. "Just run, image already initialized"
		^ processWrapper ]
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
PhLImage >> location [ 
	^ file fullName
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
PhLImage >> originTemplateUrl [

	^ self originTemplate 
		ifNotNil: [ :template | template url asString ] 
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
		ifTrue: [ pharoVersion := self versionFile contents trim ]
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

{ #category : #accessing }
PhLImage >> shouldRunInitializationScript [
	^ shouldRunInitializationScript
]

{ #category : #configuring }
PhLImage >> shouldRunInitializationScript: aBoolean [
	shouldRunInitializationScript := aBoolean.
	self serializeMetadata.
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
	^ self file parent / self class versionFileName
]

{ #category : #'private - accessing' }
PhLImage >> vmManager [
	^ vmManager ifNil: [ vmManager := PhLVirtualMachineManager forImage: self file ]
]
