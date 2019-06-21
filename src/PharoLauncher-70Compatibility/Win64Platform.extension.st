Extension { #name : #Win64Platform }

{ #category : #'*PharoLauncher-70Compatibility' }
Win64Platform >> accept: aVisitor [

	^ aVisitor visitWindows64: self
]
