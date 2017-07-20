private
imageVersionFileCreationInstructions
	^ '''{1}'' asFileReference writeStreamDo: [ :stream | 
			stream 
				<< SystemVersion current major asString
				<< SystemVersion current minor asString ]'
		format: { self imageVersionFile fullName }