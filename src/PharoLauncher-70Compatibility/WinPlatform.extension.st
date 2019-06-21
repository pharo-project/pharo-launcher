Extension { #name : #WinPlatform }

{ #category : #'*PharoLauncher-70Compatibility' }
WinPlatform >> accept: aVisitor [

	^ aVisitor visitWindows: self
]
