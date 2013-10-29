public
undoAll
	self
		activateStartupActions;
		doRaiseWarningForMissingChangesOrSourcesFiles;
		activateDeprecationWarnings;
		deactivateDeployed;
		removeFromStartupList