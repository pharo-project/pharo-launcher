Extension { #name : #Unix32Platform }

{ #category : #'*PharoLauncher-70Compatibility' }
Unix32Platform >> accept: aVisitor [

	^ aVisitor visitUnix32: self
]
