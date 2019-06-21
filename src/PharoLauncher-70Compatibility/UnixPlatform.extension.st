Extension { #name : #UnixPlatform }

{ #category : #'*PharoLauncher-70Compatibility' }
UnixPlatform >> accept: aVisitor [

	^ aVisitor visitUnix: self
]
