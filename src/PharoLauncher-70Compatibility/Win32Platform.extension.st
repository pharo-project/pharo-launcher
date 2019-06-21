Extension { #name : #Win32Platform }

{ #category : #'*PharoLauncher-70Compatibility' }
Win32Platform >> accept: aVisitor [

	^ aVisitor visitWindows32: self
]
