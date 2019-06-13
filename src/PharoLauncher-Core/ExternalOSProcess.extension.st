Extension { #name : #ExternalOSProcess }

{ #category : #'*PharoLauncher-Core' }
ExternalOSProcess >> isSuccess [ 
	^ self succeeded
]
