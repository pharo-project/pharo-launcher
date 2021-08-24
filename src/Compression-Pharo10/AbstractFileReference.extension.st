Extension { #name : #AbstractFileReference }

{ #category : #'*Compression-Pharo10' }
AbstractFileReference >> ifAbsent: aBlock [
	"Return self, or evaluate the block if I do not exist"

	^ self exists ifTrue: [ self ] ifFalse: [ aBlock cull: self ]
]
