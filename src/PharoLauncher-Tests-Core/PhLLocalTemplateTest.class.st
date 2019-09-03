Class {
	#name : #PhLLocalTemplateTest,
	#superclass : #PhLAbstractTemplateTest,
	#category : 'PharoLauncher-Tests-Core'
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
