Extension { #name : #ZipDirectoryMember }

{ #category : #'*PharoLauncher-ZipArchive' }
ZipDirectoryMember >> localFileName: aString [

	self localFileNameFrom: aString asFileReference
]

{ #category : #'*PharoLauncher-ZipArchive' }
ZipDirectoryMember >> localFileNameFrom: aFileReference [

	super localFileName: (aFileReference basename copyWith: $/).
	aFileReference exists ifFalse: [ ^ self ].
	self modifiedAt: aFileReference entry modificationTime.
]

{ #category : #'*PharoLauncher-ZipArchive' }
ZipDirectoryMember class >> newFromDirectory: aFileReference [
	^(self new) localFileNameFrom: aFileReference; yourself
]
