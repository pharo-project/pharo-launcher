"
I'm an object that can create new identical images. I have a name to distinguish myself from other templates.

Currently, all templates are represented by a zip file locally or on the network.

"
Class {
	#name : 'PhLAbstractTemplate',
	#superclass : 'PhLObject',
	#instVars : [
		'name',
		'shortName'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'actions' }
PhLAbstractTemplate >> extractTo: targetDirectory [
	"Extract myself to aDirectory. Name the resulting image aString"

	PharoLauncherApplication default
		pushProgress: 'Extract template'
		with: [ :bar |
			| archive extractionDir |
			bar
				label: 'Downloading zip archive';
				current: 25.
			archive := self zipArchive.
			bar
				label: 'Extracting archive to target directory';
				current: 75.
			extractionDir := targetDirectory / 'private-extracted'.
			[ self extractZipArchive: archive into: extractionDir.
			  self relocateImageFilesFrom: extractionDir to: targetDirectory ]
				ensure: [ extractionDir ensureDeleteAll ] ].
	"Will serialize image metadata with the template information"
	^ (PhLImage location: targetDirectory / self name , 'image')
		  originTemplate: self
]

{ #category : 'private' }
PhLAbstractTemplate >> extractZipArchive: zipFile into: targetDirectory [
	"Unzip zipFile inside a temporary subdirectory of aDirectory. Return a reference to the subdirectory. The subdirectory can and must be deleted by the caller"
	PharoLauncherApplication default
		pushProgress: ('Extracting {1}' format: { zipFile isStream ifTrue: [ '' ] ifFalse: [ zipFile basename ] }) 
		with: [ :bar | | zip |	
			"It will crash if directory already exists. And that's good :-)"
			targetDirectory createDirectory. 
			[
				zip := ZipArchive new.
				zip readFrom: zipFile.
				bar max: zip numberOfMembers.
				zip extractAllTo: targetDirectory informing: bar.
			]
			on: Error
			do: [ :error | 
				error messageText = 'can''t find EOCD position'
					ifTrue: [ PhLCorruptedTemplateError signal ]
					ifFalse: [ error pass ] ] ]
]

{ #category : 'testing' }
PhLAbstractTemplate >> hasChildren [
	^ false
]

{ #category : 'testing' }
PhLAbstractTemplate >> isTemplate [
	^ true
]

{ #category : 'accessing' }
PhLAbstractTemplate >> name [
	^ name
]

{ #category : 'printing' }
PhLAbstractTemplate >> printOn: aStream [
	aStream
		nextPutAll: 'Image template (';
		nextPutAll: name;
		nextPutAll: ')'
]

{ #category : 'private' }
PhLAbstractTemplate >> relocateImageFilesFrom: aDirectory to: targetDirectory [
	| imageFile |
	
	imageFile := aDirectory allFiles detect: [ :aFile | '*.image' match: aFile basename ].	
		
	self renameFilesIfNeeded: imageFile.
	targetDirectory ensureCreateDirectory.
	imageFile parent allFiles 
		do: [ :each | each moveTo: targetDirectory ]
]

{ #category : 'private' }
PhLAbstractTemplate >> renameFilesIfNeeded: imageFile [
	| changesFile |
		
	imageFile basename = (self name , '.image')
		ifTrue: [ ^ self "no need to rename" ].

	"A changes file must have the same name and be in the same directory as the image file"
	changesFile := imageFile parent / imageFile basenameWithoutExtension , 'changes'.

	imageFile renameTo: self name , '.image'.
	changesFile renameTo: self name , '.changes'
]

{ #category : 'actions' }
PhLAbstractTemplate >> renameTo: aString [
	name := aString
]

{ #category : 'accessing' }
PhLAbstractTemplate >> shortName [
	^ shortName
]

{ #category : 'accessing' }
PhLAbstractTemplate >> shortName: aString [ 
	shortName := aString
]

{ #category : 'testing' }
PhLAbstractTemplate >> shouldComputeChildrenLazily [ 
	^ false
]

{ #category : 'querying' }
PhLAbstractTemplate >> suggestedImageName [
	^ self name
]

{ #category : 'accessing' }
PhLAbstractTemplate >> zipArchive [
	"Return a reference to the archive file representing this template"
	^ self subclassResponsibility
]
