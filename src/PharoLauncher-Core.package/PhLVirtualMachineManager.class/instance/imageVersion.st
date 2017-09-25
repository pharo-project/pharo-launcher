accessing
imageVersion
	"get the Pharo version of the image"
	^ imageVersion ifNil: 
		[ self imageVersionFromFile ifNil:
			[ | command |
			command := String streamContents: [ :stream |
				stream
					<< 'cd "' << self compatibleVm executableFolderPath << '" && '.
				Smalltalk os isUnix 
					ifTrue: [ stream << 'export SQUEAK_PLUGINS="" && ' ].
				stream 
					<< $" << self compatibleVm executablePath << $"
					<< (Smalltalk os isUnix ifTrue: [ ' --nodisplay ' ] ifFalse: [ ' --headless ' ]) 
					<< $" << imageFile fullName utf8Encoded asString << '" --no-default-preferences eval '
					<< $" << self imageVersionFileCreationInstructions << $" ].
			OSProcess thisOSProcess waitForCommand: command.
			"we have just generated the version file, get the value"
			self imageVersionFromFile ] ]