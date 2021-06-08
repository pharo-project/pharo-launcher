Extension { #name : #ZipArchive }

{ #category : #'*PharoLauncher-Spec2' }
ZipArchive >> directoryMembersDo: aBlock [

	self members
		select: [ :each | each isDirectory ]
		thenDo: aBlock
]

{ #category : #'*PharoLauncher-Spec2' }
ZipArchive >> fileMembersDo: aBlock [

	self members
		reject: [ :each | each isDirectory ]
		thenDo: aBlock
]
