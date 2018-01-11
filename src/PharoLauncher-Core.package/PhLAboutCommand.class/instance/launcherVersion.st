querying
launcherVersion
	^ self areLoadedPackagesIdenticalToPackagesDescribedInMetacelloCurrentVersion
		ifTrue: [ self launcherCurrentMetacalloVersion ]
		ifFalse: [ 'N/A' ]