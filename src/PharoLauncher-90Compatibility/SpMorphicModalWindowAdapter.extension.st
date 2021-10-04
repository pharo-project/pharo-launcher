Extension { #name : #SpMorphicModalWindowAdapter }

{ #category : #'*PharoLauncher-90Compatibility' }
SpMorphicModalWindowAdapter >> open [

	backdropMorph := FullscreenMorph new
		color: self theme modalBackdropColor;
		on: #click send: #mouseClick:onBackdrop: to: self;
		openInWorld;
		yourself.

	self widget beSticky.
	self presenter windowIsOpening.
	"I am copying here what is defined in SystemWindow>>#openModal (but introducing the centered 
	 check inbetween because #openInWorld will use the RealEstateAgent to position the window 
	 and we want to (maybe) center it before showing it."
	self widget openInWorld.
	self presenter isCentered 
		ifTrue: [ self centered ].
	self presenter windowIsOpening.
	self waitWhile: [ self widget isInWorld ]
]
