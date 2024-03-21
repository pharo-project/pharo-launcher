Extension { #name : #ZipArchiveMember }

{ #category : #'*PharoLauncher-Tests-Debug' }
ZipArchiveMember >> binaryContentsFrom: start to: finish [
	"Answer my contents as a string."
	| s |
	s := (ByteArray new: finish - start + 1) writeStream.
	self extractTo: s from: start to: finish.
	^s contents
]
