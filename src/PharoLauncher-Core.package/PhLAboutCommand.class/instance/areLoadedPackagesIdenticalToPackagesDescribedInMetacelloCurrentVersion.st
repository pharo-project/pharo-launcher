querying
areLoadedPackagesIdenticalToPackagesDescribedInMetacelloCurrentVersion
	^ self launcherMTProject packages allSatisfy: 
		[ :package |
		package workingCopy needsSaving 
			ifTrue: [ false ]
			ifFalse: [ package version = (MTVersion fromVersionName: package workingCopy ancestors first name) ] ]