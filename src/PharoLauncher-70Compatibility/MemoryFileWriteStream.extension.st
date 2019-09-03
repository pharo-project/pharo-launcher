Extension { #name : #MemoryFileWriteStream }

{ #category : #'*PharoLauncher-70Compatibility' }
MemoryFileWriteStream >> position: anInteger [
	"Set the current position for accessing the objects to be anInteger, as long 
	as anInteger is within the bounds of the receiver's contents. If it is not, 
	create an error notification."

	stream position: anInteger
]
