as yet unclassified
defaultSpec

	^{ #ComposableSpec.
			#add:. {{#model. #listModel}. #layout:.  #(FrameLayout
															bottomOffset: -30) }.
			#add:. {{#model. #toolbarModel}. #layout:.  #(FrameLayout
															topFraction: 1
															topOffset: -22) }.}