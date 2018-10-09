accessing
imageVersionCommandWithPreferences: shouldUsePreferences
	^ String
		streamContents: [ :stream | 
			stream << 'cd "' << self compatibleVm executableFolderPath << '" && '.
			Smalltalk os isUnix
				ifTrue: [ stream << 'export SQUEAK_PLUGINS="" && ' ].
			stream << $" << self compatibleVm executablePath << $"
				<<
					(Smalltalk os isUnix
						ifTrue: [ ' --nodisplay ' ]
						ifFalse: [ ' --headless ' ]) << $"
				<< imageFile fullName
				<< '" '.
			shouldUsePreferences ifFalse: [ stream << '--no-default-preferences ' ].
			stream
				<< 'eval '
				<< $"	<< self imageVersionFileCreationInstructions << $" ]