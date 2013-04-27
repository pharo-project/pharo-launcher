specs
defaultSpec
	<spec>
	^ { #Panel.
			#changeTableLayout.
			#listDirection:.		#rightToLeft.
			#addMorph:. {#model.	#refreshButtonModel.}.
			#addMorph:. {#model.	#loadingButtonModel.}.
			#hResizing:.	#spaceFill.
			#vResizing:.	#shrinkWrap.	}