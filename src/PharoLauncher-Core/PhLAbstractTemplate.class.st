"
I'm an object that can create new identical images. I have a name to distinguish myself from other templates.

Currently, all templates are represented by a zip file locally or on the network.

"
Class {
	#name : #PhLAbstractTemplate,
	#superclass : #PhLObject,
	#instVars : [
		'name'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #actions }
PhLAbstractTemplate >> extractTo: aDirectory [
	"Extract myself to aDirectory, making sure to name the resulting image after me"

	"In most cases, you probably want to call #extractTo:named: and let the user choose the new name for the image."

	self halt. "Not used"
	self extractTo: aDirectory named: self name
]

{ #category : #actions }
PhLAbstractTemplate >> extractTo: aDirectory named: aString [
	"Extract myself to aDirectory. Name the resulting image aString"
	| extractionDirectory archive |
	PharoLauncherApplication default 
		pushProgress: 'Extract template'
		with: [ :bar | 
			bar label: 'Downloading zip archive';
			current: 25.
			archive := self zipArchive.
			bar label: 'Extracting archive to target directory';
			current: 75.
			extractionDirectory := self extractZipArchive: archive to: aDirectory.
			self relocateImageFilesFrom: extractionDirectory to: aDirectory withName: aString.
			extractionDirectory deleteAll
	].
	"Will serialize image metadata with the template information"
	^ (PhLImage location: aDirectory / aString , 'image') 
		originTemplate: self.
]

{ #category : #private }
PhLAbstractTemplate >> extractZipArchive: zipFile to: aDirectory [
	"Unzip zipFile inside a temporary subdirectory of aDirectory. Return a reference to the subdirectory. The subdirectory can and must be deleted by the caller"
	| tempDirectory |

	PharoLauncherApplication default
		pushProgress: ('Extracting {1}' format: { zipFile isStream ifTrue: [ '' ] ifFalse: [ zipFile basename ] }) 
		with: [ :bar | | zip |	
			"We have to go through a temporary directory because we don't know where 
			 the interesting files are in the archive (maybe at the root or maybe in 
			 a subdirectory)"
			tempDirectory := aDirectory / DateAndTime millisecondClockValue asString.
			"It will crash if directory already exists. And that's good :-)"
			tempDirectory createDirectory. 
			[
				zip := ZipArchive new.
				zip readFrom: zipFile.
				bar max: zip numberOfMembers.
				zip extractAllTo: tempDirectory informing: bar.
			]
			on: Error
			do: [ :error | 
				error messageText = 'can''t find EOCD position'
					ifTrue: [ PhLCorruptedTemplateError signal ]
					ifFalse: [ error pass ] ] ].

	^ tempDirectory
]

{ #category : #testing }
PhLAbstractTemplate >> hasChildren [
	^ false
]

{ #category : #testing }
PhLAbstractTemplate >> isTemplate [
	^ true
]

{ #category : #accessing }
PhLAbstractTemplate >> name [
	^ name
]

{ #category : #printing }
PhLAbstractTemplate >> printOn: aStream [
	aStream
		nextPutAll: 'Image template (';
		nextPutAll: name;
		nextPutAll: ')'
]

{ #category : #private }
PhLAbstractTemplate >> relocateImageFilesFrom: extractionDirectory to: targetDirectory withName: targetName [
	"Move the image files from anywhere within extractionDirectory (even subdirectories) to aDirectory and give the image the name aString"

	| imageFile changesFile sourcesFile versionFile |
	imageFile := extractionDirectory allFiles detect: [ :aFile | '*.image' match: aFile basename ].	"A changes file must have the same name and be in the same directory as the image file:"
	changesFile := imageFile parent / imageFile basenameWithoutExtension , 'changes'.
	sourcesFile := imageFile parent / imageFile basenameWithoutExtension , 'sources'.
	versionFile := imageFile parent / PhLImage versionFileName.
	imageFile = (targetDirectory / targetName , 'image')
		ifTrue: [ ^ self "no need to relocate" ].
	imageFile moveTo: targetDirectory / targetName , 'image'.
	changesFile moveTo: targetDirectory / targetName , 'changes'.
	sourcesFile exists 
		ifTrue: [ sourcesFile moveTo: targetDirectory / sourcesFile basename ]
		ifFalse: [ "ugly hack to handle Pharo 7 - 64 bits images not following the naming scheme"
			extractionDirectory allFiles 
				detect: [ :aFile | '*.sources' match: aFile basename ]
				ifFound: [ :aFile | aFile moveTo: targetDirectory / aFile basename ] ].
	versionFile exists 
		ifTrue: [ versionFile moveTo: targetDirectory / versionFile basename ]
]

{ #category : #actions }
PhLAbstractTemplate >> renameTo: aString [
	name := aString
]

{ #category : #testing }
PhLAbstractTemplate >> shouldComputeChildrenLazily [ 
	^ false
]

{ #category : #querying }
PhLAbstractTemplate >> suggestedImageName [
	^ self name
]

{ #category : #accessing }
PhLAbstractTemplate >> zipArchive [
	"Return a reference to the archive file representing this template"
	^ self subclassResponsibility
]
