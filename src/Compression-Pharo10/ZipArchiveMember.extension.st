Extension { #name : #ZipArchiveMember }

{ #category : #'*Compression-Pharo10' }
ZipArchiveMember class >> newFromDirectory: aFileReference localName: localName [
	^ZipDirectoryMember newFromDirectory: aFileReference localName: localName
]
