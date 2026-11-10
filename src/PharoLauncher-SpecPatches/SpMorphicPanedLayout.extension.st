Extension { #name : 'SpMorphicPanedLayout' }

{ #category : '*PharoLauncher-SpecPatches-PanedFractionalPosition' }
SpMorphicPanedLayout >> heightPositionIn: aPoint [ 

	^ self position < 1 
		ifTrue: [ (aPoint y * self position) asInteger ]
		ifFalse: [ self position asInteger ]
]

{ #category : '*PharoLauncher-SpecPatches-PanedFractionalPosition' }
SpMorphicPanedLayout >> widthPositionIn: aPoint [

	^ self position < 1
		  ifTrue: [ (aPoint x * self position) asInteger ]
		  ifFalse: [ self position asInteger ]
]
