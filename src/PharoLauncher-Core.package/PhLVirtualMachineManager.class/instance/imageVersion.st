accessing
imageVersion
	"get the Pharo version of the image"
	^ imageVersion ifNil: 
		[ self imageVersionFromFile ifNil:
			[ | command |
			command := String streamContents: [ :stream |
				stream 
					<< $" << self compatibleVm << $"
					<< (Smalltalk os isUnix ifTrue: [ ' --nodisplay ' ] ifFalse: [ ' --headless ' ]) 
					<< $" << imageFile fullName << '" --no-default-preferences eval '
					<< $" << self imageVersionFileCreationInstructions << $" ].
			OSProcess thisOSProcess waitForCommand: command.
			"we have just generated the version file, get the value"
			self imageVersionFromFile ] ]