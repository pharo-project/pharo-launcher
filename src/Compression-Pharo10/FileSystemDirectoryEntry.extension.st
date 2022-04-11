Extension { #name : #FileSystemDirectoryEntry }

{ #category : #'*Compression-Pharo10' }
FileSystemDirectoryEntry >> addArchiveMemberAs: aName in: anArchive [

	self isDirectory
		ifTrue: [ anArchive addDirectory: self reference as: aName ]
		ifFalse: [ anArchive addFile: self reference as: aName ]
]

{ #category : #'*Compression-Pharo10' }
FileSystemDirectoryEntry >> ifAbsent: aBlock [
	"Return self, or evaluate the block if I do not exist"

	^ self exists ifTrue: [ self ] ifFalse: [ aBlock cull: self ]
]
