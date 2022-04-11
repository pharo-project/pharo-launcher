Extension { #name : #ZipDirectoryMember }

{ #category : #'*Compression-Pharo10' }
ZipDirectoryMember class >> newFromDirectory: aFileReference localName: localName [

	^ self new
		  externalFile: aFileReference;
		  localFileName: localName;
		  yourself
]
