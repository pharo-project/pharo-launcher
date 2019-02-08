Extension { #name : #Archive }

{ #category : #'*PharoLauncher-ZipArchive' }
Archive >> addDirectory: aFileReference [
	^self addDirectory: aFileReference as: aFileReference path pathString

]

{ #category : #'*PharoLauncher-ZipArchive' }
Archive >> addDirectory: aFileReference as: anotherFileName [
	| newMember |
	newMember := self memberClass newFromDirectory: aFileReference.
	self addMember: newMember.
	newMember localFileName: anotherFileName.
	^newMember
]

{ #category : #'*PharoLauncher-ZipArchive' }
Archive >> addFile: aFileReference [
	^self addFile: aFileReference as: aFileReference path pathString
]

{ #category : #'*PharoLauncher-ZipArchive' }
Archive >> addFile: aFileReference as: anotherFileName [
	| newMember |
	newMember := self memberClass newFromFile: aFileReference.
	newMember localFileName: anotherFileName.
	self addMember: newMember.
	^newMember
]
