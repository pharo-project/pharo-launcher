Extension { #name : #MacOSPlatform }

{ #category : #'*PharoLauncher-70Compatibility' }
MacOSPlatform >> accept: aVisitor [

	^ aVisitor visitMacOS: self
]
