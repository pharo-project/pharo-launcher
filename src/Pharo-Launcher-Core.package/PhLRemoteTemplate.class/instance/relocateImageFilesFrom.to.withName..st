actions
relocateImageFilesFrom: extractionDirectory to: aDirectory withName: aString
	| imageFileReference changesFileReference |
	imageFileReference := extractionDirectory allFiles detect: [ :aFile | '*.image' match: aFile basename  ]. 
	changesFileReference := imageFileReference copy.
	imageFileReference moveTo: aDirectory / aString, 'image'.
	changesFileReference := changesFileReference parent / changesFileReference basenameWithoutExtension, 'changes'.
	changesFileReference moveTo: aDirectory / aString, 'changes'.
	