Extension { #name : #ZipArchiveMember }

{ #category : #'*PharoLauncher-ZipArchive' }
ZipArchiveMember class >> newFromDirectory: aFileReference [
	^ZipDirectoryMember newFromDirectory: aFileReference
]

{ #category : #'*PharoLauncher-ZipArchive' }
ZipArchiveMember class >> newFromFile: aFileReference [
	^ZipNewFileMember newFromFile: aFileReference
]
