querying
vm
	| vmPath |
	UIManager default
		informUserDuring: [ :bar | 
			bar label: 'Determining Image version'.
			vmPath := self availableVirtualMachines 
				at: self imageVersion
			ifAbsent: 
				[ 
				bar 
					label: 'Fetching VM to run Pharo ', self imageVersion , ' images';
					current: 25.
				self fetchVm.
				vmPath := self availableVirtualMachines at: self imageVersion.
				self ensureIsExecutable: vmPath.
				bar 
					label: 'Fetching sources files for Pharo ', self imageVersion;
					current: 50.
				self fetchSourcesFiles.
				bar 
					label: 'Running the image';
					current: 100.
				vmPath ]. ].
	^ vmPath