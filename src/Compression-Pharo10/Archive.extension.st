Extension { #name : #Archive }

{ #category : #'*Compression-Pharo10' }
Archive >> addDirectory: aFileReference as: anotherFileName [
	| newMember |
	newMember := self memberClass newFromDirectory: aFileReference localName: anotherFileName.
	self addMember: newMember.
	newMember localFileName: anotherFileName.
	^newMember
]

{ #category : #'*Compression-Pharo10' }
Archive >> addTree: aFileReference relativeTo: relativePath match: aBlock [
	| matches |
	matches := aFileReference  entries select: [ :entry | aBlock value: entry ].
	matches
		do: [ :entry | | newMember archiveFilePath |
			archiveFilePath := entry asFileReference relativeTo: relativePath.
			newMember := entry addArchiveMemberAs: archiveFilePath pathString in: self.  			
			entry isDirectory 
				ifTrue: [ self addTree: entry asFileReference relativeTo: relativePath match: aBlock ].
	]

]
