Extension { #name : #SpMorphicToolbarButtonAdapter }

{ #category : #'*PharoLauncher-90Compatibility' }
SpMorphicToolbarButtonAdapter >> execute: isPressed [ 

	self presenter selected: isPressed.
	self presenter action ifNotNil: [ :action | action cull: self presenter ]
]
