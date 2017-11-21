accessing
imageVersion
	"get the Pharo version of the image"

	^ imageVersion
		ifNil: [ self imageVersionFromFile
				ifNil: [ 	PhLProcessWrapper waitForCommand: self imageVersionCommand.
					"we have just generated the version file, get the value"
					self imageVersionFromFile 
						ifNil: [ "Command probably failed, try to run without --no-default-preferences option (not available in Pharo 2)"
							PhLProcessWrapper waitForCommand: (self imageVersionCommandWithPreferences: true).	
							"we have just generated the version file, get the value"
							self imageVersionFromFile ] ] ]