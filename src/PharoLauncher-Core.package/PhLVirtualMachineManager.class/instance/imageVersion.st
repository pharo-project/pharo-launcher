accessing
imageVersion
	"get the Pharo version of the image"

	^ imageVersion ifNil: 
		[ [ self imageVersionFromFile ]
			on: PhLImageVersionDeterminationError
			do: [ "no version file, generate it"
					[ self imageVersionFromFileWith: self imageVersionCommand ]
						on: PhLImageVersionDeterminationError
						do: [ "Command probably failed, try to run without --no-default-preferences option (not available in Pharo 2)"
								self imageVersionFromFileWith: (self imageVersionCommandWithPreferences: true) ] ] ]