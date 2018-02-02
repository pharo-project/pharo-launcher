querying
launcherPackageList
	^ (self launcherMTProject packages collect: [ :package | package workingCopy ancestors first name ])
		"join: "