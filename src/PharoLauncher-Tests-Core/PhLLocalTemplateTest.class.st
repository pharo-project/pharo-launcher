Class {
	#name : #PhLLocalTemplateTest,
	#superclass : #PhLAbstractTemplateTest,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #coverage }
PhLLocalTemplateTest >> classToBeTested [
	^ PhLLocalTemplate 
]

{ #category : #'instance-creation' }
PhLLocalTemplateTest >> newTemplate [
	^ PhLLocalTemplate name: 'Test' zipFile: root / 'Test.zip'
]

{ #category : #tests }
PhLLocalTemplateTest >> testDeserializationGivesAFileReferenceToTheTemplate [
	| template |
	template := STON fromString: 'PhLLocalTemplate{#name:''Test'',#zipFile:''/phl-abstract-template-test-template-extraction.zip''}'.
	
	self assert: (template zipArchive isKindOf: FileReference).
]

{ #category : #tests }
PhLLocalTemplateTest >> testSerializationDoesNotIncludeZipFileButAFileReferenceToIt [
	| template zipFile stonString |
	zipFile := '/phl-abstract-template-test-template-extraction.zip' asFileReference.
	template := PhLLocalTemplate name: 'Test' zipFile: zipFile.
	
	stonString := STON toString: template.
	
	self assert: stonString equals: 'PhLLocalTemplate{#name:''Test'',#zipFile:FILE[''/phl-abstract-template-test-template-extraction.zip'']}'.
]

{ #category : #tests }
PhLLocalTemplateTest >> testTemplateExtractionGenerateImageMetadata [
	| template destination archive zipFile metadataFile |
	zipFile := root / 'phl-abstract-template-test-template-extraction.zip'.
	template := PhLLocalTemplate name: 'Test' zipFile: zipFile.
	archive := ZipArchive new.
	archive
		addDeflateString: 'foo' as: 'bar.image';
		addDeflateString: 'foo' as: 'bar.changes'.
	template zipArchive asFileReference
		binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
	destination := (root / 'new') ensureCreateDirectory.
	
	template extractTo: destination named: 'new'.
	
	metadataFile := destination / PhLImage metadataFileName.
	self assert: metadataFile exists.
	self assert: (metadataFile contents includesSubstring: zipFile basename).
	zipFile ensureDelete.
]
