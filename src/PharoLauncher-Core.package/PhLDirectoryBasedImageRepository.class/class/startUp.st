system startup
startUp
	"Fix the Location because the platform or computer can have changed"

	(Location notNil and: [ Location exists not ])
		ifTrue: [ 
			"We could probably always set to nil without the previous checks, but I'm not sure because it may depend on #startUp order of classes (e.g., if PhLSettingBrowser class>>#startUp is first, we may have a problem)."
			Location := nil ]