"
I represent a Pharo (or other) image. I live in a particular location and have a name. Users can launch me.

#VM Matching
I am matched to the appropriate VM to launch me via my ""version file"", which is in the same folder as me, and whose name is the string returned by #versionFileName. My version file's contents are of the form: `{prefix}{version}`*, where:
- {prefix} is empty for standard Pharo images. It is made available and used by custom images/VMs e.g. Gtoolkit uses 'gt-'
- {version} is whatever convention is used by the image/VM type. For standard Pharo, it is the Pharo version with dots removed. Examples:
  - Pharo 9.0 -> `90`.
  - Gtoolkit 0.8.83 -> `gt-0.8.83`.
* This pattern is the same as the matching VM root folder minus the architecture. See PhLVirtualMachine comment, ""Filesystem Location"" section for more info.

#Customized Image Types
Subclassing me allows you to customize things like:
- Which VM to use (if not using the standard mapping from Pharo image version to Pharo VM). For example, GToolkit or Squeak VMs. See below for more details.
- Default image arguments (by overriding #defaultArguments). For example, GToolkit needs this because the image immediately closes after startup unless `'--no-quit'` is supplied.

##Custom VM Mapping
with contents `{prefix}{version}` e.g. `gt-0.8.83`. This is the same as the VM root folder minus the architecture. See PhLVirtualMachine comment, ""Filesystem Location"" section for more info.
Let's say you have an image that should be run on a custom VM (i.e. not a standard Pharo one)... subclass me, overriding `#versionPrefix` to match the `#versionPrefix` returned by an appropriate PhLVirtualMachine subclass. N.B. To change the VM of an image that has previously been launched with another VM, you may have to delete the image's metainfo file, which would cache the VM info.

##Installing an existing (on the filesystem) image in Launcher
Currently, custom images can't be downloaded via Launcher due to differences in URL and other conventions, although this could probably be implemented if someone was interested enough. To create a template from a custom image, you must do the following:
1. Download the image and changes file.
2. Create a folder in your Launcher images folder which contains the image and changes file. Both files should have the same basename as the folder. For example, `/path/to/launcher_images/Gtoolkit 0.8.83`, `Gtoolkit 0.8.83.image` and `Gtoolkit 0.8.83.changes`.
3. Create a ""version file"" as described in ""Custom VM Mapping"" above.
4. Open or refresh Launcher. The image should appear.

##Template Creation
To create a template from a custom image, prepare an image as described above in ""Installing..."" and then select the image in Launcher, bring up its context menu, choose ""Create Template"" and go through the dialogs.
The template should now be available to create new images.

Instance Variables
	file:		a reference to the .image file
	description: user description of the image
	formatNumber: image format number encoded in the image header
	architecture: is the image 32-bit or 64-bit
	pharoVersion: the Pharo version number of the image 
	originTemplate: template that was used to create this image
	
My metadata are serialized when setting description, template or before launching the image (implies to compute formatNumber, architecture and pharo version).
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
	#classInstVars : [
		'reader'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLImage class >> classForLocation: imageFileReference [
	^ self allSubclasses
		detect: [ :cls | cls isSubclassForLocation: imageFileReference ]
		ifNone: [ self ]
]

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
PhLImage class >> imageFromMetadata: imageFileReference ifAbsent: aBlock [
	"Will recreate the image object from its STON serialized version if possible"

	^ imageFileReference parent / self metadataFileName
			readStreamDo: [ :stream | 
				| object |
				object := (self stonReader on: stream) next.
				object asPhLImage ]
			ifAbsent: aBlock
]

{ #category : #initialization }
PhLImage class >> initialize [
	SessionManager default registerUserClassNamed: self name
]

{ #category : #testing }
PhLImage class >> isSubclassForLocation: imageFileReference [
	| versionFile |
	versionFile := imageFileReference parent / self versionFileName.
	^ versionFile exists and: [ versionFile contents beginsWith: self versionPrefix ]
]

{ #category : #'instance creation' }
PhLImage class >> location: imageFileReference [
	| instance |
	instance := self
		imageFromMetadata: imageFileReference
		ifAbsent: [ (self classForLocation: imageFileReference) new ].
	^ instance
		setLocation: imageFileReference;
		yourself
]

{ #category : #accessing }
PhLImage class >> metadataFileName [
	^ 'meta-inf.ston'
]

{ #category : #'system startup' }
PhLImage class >> startUp: isImageStarting [

	isImageStarting ifTrue: [ reader := nil ]
]

{ #category : #serialization }
PhLImage class >> stonAllInstVarNames [
	^ super stonAllInstVarNames reject: [ :varName | varName = #file ]
]

{ #category : #accessing }
PhLImage class >> stonReader [
	"The ston reader is building caches when reading a file. Since we read *a lot* of files, we cache a reader with all the built caches."

	^ reader 
		ifNil: [ reader := STONReader new ]
		ifNotNil: [ reader reset; yourself ]
]

{ #category : #accessing }
PhLImage class >> versionFileName [
	^ 'pharo.version'
]

{ #category : #accessing }
PhLImage class >> versionPrefix [
	"Used in matching me to a VM. See class comment, 'VM Matching' section"

	^ ''
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

{ #category : #converting }
PhLImage >> asPhLImage [
	^ self
]

{ #category : #testing }
PhLImage >> canBeLaunched [
	^ self architecture = '32' 
		ifTrue: [ self os canRun32bitApp ]
		ifFalse: [ true "we do not manage the case where a 64-bit image want to be launched on a 32-bit OS"]
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
PhLImage >> defaultArguments [
	^ OrderedCollection new
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
	^ (self pharoVersion isNil or: [ self pharoVersion = '' ])
			ifFalse: [ 
				self vmManager imageVersion: self pharoVersion.
				self pharoVersion ]
			ifTrue: [ self computePharoVersion ]
	
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

{ #category : #initialization }
PhLImage >> initialize [
	super initialize.
	launchConfigurations := OrderedCollection new.
	shouldRunInitializationScript := true
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

	self canBeLaunched
		ifFalse: [ PhLArchitectureError signalImage: self. ^ self ].

	architectureWarningEnabled := true.
	continue := true.
	[ [ | processWrapper|
		processWrapper := (aPhLLaunchConfiguration launchProcess) runUnwatch.
		self doNotRunInitializationScript. "Just run, image already initialized"
		^ processWrapper ]
	on: PhLImageVersionDeterminationError
	do: [ :error | error uiAlert ] ]
	on: PhLArchitectureMismatchWarning
	do: [ :warning |
		architectureWarningEnabled ifTrue: [ 	
			architectureWarningEnabled := false. "only raise one warning"
			continue := self showWarning: warning ].
		continue ifTrue: [ warning resume ] ]
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

{ #category : #'private - accessing' }
PhLImage >> os [
	^ OSPlatform current
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
	file exists ifFalse: [ "image deleted" ^ self ].

	(file parent / self class metadataFileName)
		writeStreamDo: [ :stream | stream nextPutAll: self stonString ]
]

{ #category : #initialization }
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

{ #category : #'private ui' }
PhLImage >> showWarning: warning [
	| continue |

	continue := true.
	(PhLLaunchImageCommand warnOnArchMismatch)
		ifTrue: [ 
			continue := (PharoLauncherApplication default newConfirm 
				title: warning name ;
				message: warning longDescription;
				openModalWithSpecParent: PharoLauncherApplication default topWindow) ].
			
	^ continue
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
