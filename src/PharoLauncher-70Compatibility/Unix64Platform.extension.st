Extension { #name : #Unix64Platform }

{ #category : #'*PharoLauncher-70Compatibility' }
Unix64Platform >> accept: aVisitor [

	^ aVisitor visitUnix64: self
]
