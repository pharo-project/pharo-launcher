accessing
announcer
	^ CommandAnnouncer ifNil: [ CommandAnnouncer := Announcer new ]