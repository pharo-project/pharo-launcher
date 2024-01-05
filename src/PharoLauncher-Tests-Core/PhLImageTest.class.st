Class {
	#name : #PhLImageTest,
	#superclass : #TestCase,
	#instVars : [
		'fs',
		'image',
		'imageFileRef'
	],
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #utilities }
PhLImageTest >> createFakeVM [
	^ PhLVirtualMachine new 
		basicInitializeOn: FileLocator launcherVMsLocation / '100-x64';
		executable: FileLocator launcherVMsLocation / '100-x64' / 'Pharo';
		yourself
]

{ #category : #accessing }
PhLImageTest >> currentImageVersion [ 
	^  SystemVersion current major asString
		, SystemVersion current minor asString
]

{ #category : #running }
PhLImageTest >> setUp [
	super setUp.
	fs := FileSystem memory root.
	imageFileRef := fs / 'foo.image'.
	imageFileRef binaryWriteStreamDo: [ :stream | (ZnEndianessReadWriteStream on: stream) nextLittleEndianNumber: 4 put: 68021 ].
	image := PhLImage location: imageFileRef.
	image pharoVersion: '110'
]

{ #category : #tests }
PhLImageTest >> testCanGetDefaultLaunchConfigurationWhenNoLaunchConfiguration [
	| config |

	config := image defaultLaunchConfiguration.
	
	self 
		assert: config name
		equals: 'Default'.
]

{ #category : #tests }
PhLImageTest >> testCanInitializeImageFromMetadatafile [
	| deserializedImage |
	image 
		description: 'An image for testing purpose';
		computeArchitecture;
		originTemplate: (PhLRemoteTemplate name: 'Foo test template' url: 'https://foo.bar.org/abc/foo.zip' asZnUrl).
		
	deserializedImage := PhLImage location: fs / 'foo.image'.

	self 
		assert: deserializedImage description
		equals: image description.
	self 
		assert: deserializedImage architecture
		equals: image architecture.
	self 
		assert: deserializedImage formatNumber 
		equals: image formatNumber.
	self 
		assert: deserializedImage pharoVersion
		equals: image pharoVersion.
	self 
		assert: deserializedImage originTemplate name
		equals: image originTemplate name.
	self 
		assert: deserializedImage originTemplate url asString
		equals: image originTemplate url asString.
]

{ #category : #tests }
PhLImageTest >> testCanSerializeAndDeserializeImageLaunchConfigurationMetadata [
	| deserializedImage launchConfig deserializedLaunchConfig |
	image 	launchConfigurations. "Add default launch ocnfig to the list of configurations"
	launchConfig := image defaultLaunchConfiguration 
		imageArguments: #('foo');
		vmArguments: #(1 2);
		yourself.
		
	deserializedImage := STON fromString: image stonString.
	deserializedLaunchConfig := deserializedImage defaultLaunchConfiguration.

	self
		assert: deserializedLaunchConfig name 
		equals: launchConfig name.
	self
		assertCollection: deserializedLaunchConfig imageArguments  
		hasSameElements: launchConfig imageArguments.
	self
		assertCollection: deserializedLaunchConfig vmArguments  
		hasSameElements: launchConfig vmArguments.

]

{ #category : #tests }
PhLImageTest >> testCanSerializeAndDeserializeImageMetadata [
	| deserializedImage |
	image 
		description: 'An image for testing purpose';
		computeArchitecture;
		originTemplate: (PhLRemoteTemplate name: 'Foo test template' url: 'https://foo.bar.org/abc/foo.zip' asZnUrl).
		
	deserializedImage := STON fromString: image stonString.

	self 
		assert: deserializedImage description
		equals: image description.
	self 
		assert: deserializedImage architecture
		equals: image architecture.
	self 
		assert: deserializedImage formatNumber 
		equals: image formatNumber.
	self 
		assert: deserializedImage pharoVersion
		equals: image pharoVersion.
	self 
		assert: deserializedImage originTemplate name
		equals: image originTemplate name.
	self 
		assert: deserializedImage originTemplate url asString
		equals: image originTemplate url asString.
]

{ #category : #tests }
PhLImageTest >> testDefaultLaunchConfigurationIsRetrievedFromConfigurationListWhenAvailable [
	| config |

	config := image defaultLaunchConfiguration.
	config imageArguments: #( #foo ).
	image launchConfigurations: { config }.
		
	self 
		assert: image defaultLaunchConfiguration
		equals: config.
		
	self 
		assert: image defaultLaunchConfiguration imageArguments
		equals: #( #foo ).
]

{ #category : #tests }
PhLImageTest >> testDescriptionIsSetWhenNoDescriptionInMetadataButDescriptionFileExists [
	| desc |
	image description: nil.
	desc := 'A description from description file description.txt'.
	fs / PhLImage descriptionFileName 
		writeStreamDo: [ :stream | stream nextPutAll: desc ].

	self 
		assert: image description
		equals: desc.
]

{ #category : #tests }
PhLImageTest >> testImageNameIsNotValidWhenContainingFileSeparator [

	self deny: (PhLImage isValidName: 'fo/o').
	self deny: (PhLImage isValidName: '123\4').
]

{ #category : #tests }
PhLImageTest >> testImageNameIsValidWithLettersAndNumbers [

	self assert: (PhLImage isValidName: 'foo').
	self assert: (PhLImage isValidName: '1234').
	self assert: (PhLImage isValidName: 'Fo23')
]

{ #category : #tests }
PhLImageTest >> testPhLImageSerialization [
	| stonString |
	(image file parent / image class versionFileName)
		writeStreamDo: [ :stream | stream nextPutAll: self currentImageVersion ].
	image launchConfigurations. "create default configuration"
	image defaultLaunchConfiguration vm: self createFakeVM. "Avoid to download a VM"
	image vmManager imageFile: FileLocator launcherImagesLocation / (image name , '.image'). "do not serialize a memory FS"
	
	stonString := image stonString.
	
	"ensure we get a file locator"
	self assert: (stonString includesSubstring: '#executableRef : FileLocator {') description: 'missing executableRef: ', stonString.
	self assert: (stonString includesSubstring: '#origin : #launcherVMsLocation') description: 'missing #launcherVMsLocation origin: ', stonString.
	self assert: (stonString withInternetLineEndings includesSubstring: '#imageFile : FileLocator {
			#path : RelativePath [ ''foo.image'' ],
			#origin : #launcherImagesLocation
		}' withInternetLineEndings) description: 'missing or wrong #imageFile: ', stonString.
	"ensure VM manager is a reference"
	self assert: (stonString includesSubstring: '#manager : @2,') description: 'VM manager is not a reference: ', stonString.
]

{ #category : #tests }
PhLImageTest >> testPharoVersionIsSetWhenNoVersionInMetadataButPharoVersionFileExists [
	| version |
	
	version := '60'.
	image pharoVersion: nil.
	image versionFile 
		writeStreamDo: [ :stream | stream nextPutAll: version ].

	self 
		assert: image pharoVersion
		equals: version.
]

{ #category : #tests }
PhLImageTest >> testTemplateIsSetWhenMetadataFileInOldFormat [
	"Old metadata file was a STON file with a dictionary with only one entry:
		template -> ston representation of the template
	"
	| oldMetadataString template |
	
	image originTemplate: nil.
	oldMetadataString := '{''template'':PhLRemoteTemplate{#name:''Pharo 7.0 (development version)'',#url:ZnUrl{#scheme:#http,#host:''files.pharo.org'',#segments:OrderedCollection[''image'',''70'',''latest.zip'']}}}'.
	fs / PhLImage metadataFileName writeStreamDo: [ :stream | stream nextPutAll: oldMetadataString ].
	template := (STON fromString: oldMetadataString) at: #template.

	image := PhLImage location: fs / 'foo.image'.
	
	self 
		assert: image originTemplate class
		equals: template class.
	self 
		assert: image originTemplate name
		equals: template name.
	self 
		assert: image originTemplate url
		equals: template url.
]
