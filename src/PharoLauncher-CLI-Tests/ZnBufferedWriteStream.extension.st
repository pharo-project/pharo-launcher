Extension { #name : #ZnBufferedWriteStream }

{ #category : #'*PharoLauncher-CLI-Tests' }
ZnBufferedWriteStream >> contents [
	"Should only be used for testing"
	self flush.
	^ stream wrappedStream contents 
]
