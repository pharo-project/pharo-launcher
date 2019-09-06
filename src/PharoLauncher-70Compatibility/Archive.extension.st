Extension { #name : #Archive }

{ #category : #'*PharoLauncher-70Compatibility' }
Archive >> writeToFileNamed: aFileName [

	"Catch attempts to overwrite existing zip file"
	(self canWriteToFileNamed: aFileName)
		ifFalse: [ ^self error: (aFileName, ' is needed by one or more members in this archive') ].
	
	aFileName asFileReference
		binaryWriteStreamDo: [ :stream | self writeTo: stream ]	
]
