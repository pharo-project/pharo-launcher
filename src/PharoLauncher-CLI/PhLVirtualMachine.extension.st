Extension { #name : 'PhLVirtualMachine' }

{ #category : '*PharoLauncher-CLI' }
PhLVirtualMachine class >> extendedListPrintAttributeBlocks [

	^ self listPrintAttributeBlocks , {
		  [ :vm | vm downloadUrl ].
		  [ :vm | vm location ] }
]

{ #category : '*PharoLauncher-CLI' }
PhLVirtualMachine class >> extendedListPrintAttributeLabels [

	^ self listPrintAttributeLabels , { 'Download URL'. 'Location' }
]

{ #category : '*PharoLauncher-CLI' }
PhLVirtualMachine class >> listPrintAttributeBlocks [

	^ {
		  [ :vm | vm id ].
		  [ :vm | vm version ].
		  [ :vm | vm installationDate ifNil: [ '' ] ifNotNil: [ :date | date yyyymmdd ] ].
		  [ :vm | vm status ] }
]

{ #category : '*PharoLauncher-CLI' }
PhLVirtualMachine class >> listPrintAttributeLabels [

	^ { 'Name'. 'Version'. 'Installed on'. 'Status' }
]
