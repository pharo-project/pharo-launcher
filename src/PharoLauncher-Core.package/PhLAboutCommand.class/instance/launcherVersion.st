querying
launcherVersion

	^ [ self class package mcWorkingCopy ancestry ancestors first commit id asString ]
		on: Error do: [ 'N/A' ]