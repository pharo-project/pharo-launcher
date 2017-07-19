accessing
imageVersion
	"get the Pharo version of the image"
	^ imageVersion ifNil: 
		[ | command headlessOption |
		headlessOption := Smalltalk os isUnix ifTrue: [ '" --nodisplay "' ] ifFalse: [ '" --headless "' ].
		command := '"', self compatibleVm , headlessOption , imageFile fullName , '" --no-default-preferences ' ,
			' eval ''SystemVersion current major asString, SystemVersion current minor asString'''.
		imageVersion := (OSProcess thisOSProcess waitForCommandOutput: command) asInteger asString ]