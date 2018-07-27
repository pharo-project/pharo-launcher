action
launchWithSettings: usePharoSettings
	| architectureWarningEnabled continue |
	architectureWarningEnabled := true.
	continue := true.
	[ [ | vmCommand |
	vmCommand := (PhDVirtualMachineManager forImage: file pathString) vm.
	^ PhDProcessWrapper command: (self launchCommandWith: vmCommand useSettings: usePharoSettings) ]
		on: PhDImageVersionDeterminationError
		do: [ :error |  error uiAlert ] ]
		on: PhDArchitectureMismatchWarning
		do: [ :warning | |  |
			(PhLLaunchImageCommand warnOnArchMismatch and: [ architectureWarningEnabled  ])
				ifTrue: [ 
					architectureWarningEnabled := false. "only raise one warning"
					continue := YesNoDialogWithTickBoxWindow confirm: warning longDescription label: warning name. ].
			continue ifTrue: [ warning resume ]. ]