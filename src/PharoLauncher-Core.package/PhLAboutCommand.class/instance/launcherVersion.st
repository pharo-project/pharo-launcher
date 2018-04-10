querying
launcherVersion
	^ self areLoadedPackagesIdenticalToPackagesDescribedInMetacelloCurrentVersion
		ifTrue: [ self launcherCurrentMetacalloVersion versionString ]
		ifFalse: [ 'N/A' ]