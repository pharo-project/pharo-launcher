Extension { #name : #ZipNewFileMember }

{ #category : #'*PharoLauncher-ZipArchive' }
ZipNewFileMember >> from: aFileReference [

	| entry |
	"Now get the size, attributes, and timestamps, and see if the file exists"
	stream := aFileReference binaryReadStream.
	self localFileName: (externalFileName := aFileReference path pathString).
	entry := aFileReference entry.
	compressedSize := uncompressedSize := entry size.
	desiredCompressionMethod := compressedSize > 0 ifTrue: [ CompressionDeflated ] ifFalse: [ CompressionStored ].
	self flag: 'When we replace Files with FileSystem, the following line won''t have to jump throught hoops (FS returns aDateAndTime)'.
	self modifiedAt: entry modificationTime.

]

{ #category : #'*PharoLauncher-ZipArchive' }
ZipNewFileMember class >> newFromFile: aFileReference [
	^(self new) from: aFileReference
]
