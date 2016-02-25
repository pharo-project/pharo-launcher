action
launchWithoutSetting: aFullPathString
	"Use the VM that launched the current image to launch me"

	^ OSProcess command: (self launchCommandWith: aFullPathString), ' --no-default-preferences'