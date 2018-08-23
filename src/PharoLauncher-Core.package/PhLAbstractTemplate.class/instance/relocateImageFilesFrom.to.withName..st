private
relocateImageFilesFrom: extractionDirectory to: targetDirectory withName: targetName
	"Move the image files from anywhere within extractionDirectory (even subdirectories) to aDirectory and give the image the name aString"

	| imageFile changesFile sourcesFile versionFile |
	imageFile := extractionDirectory allFiles detect: [ :aFile | '*.image' match: aFile basename ].	"A changes file must have the same name and be in the same directory as the image file:"
	changesFile := imageFile parent / imageFile basenameWithoutExtension , 'changes'.
	sourcesFile := imageFile parent / imageFile basenameWithoutExtension , 'sources'.
	versionFile := imageFile parent / PhLVirtualMachineManager imageVersionFileName.
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