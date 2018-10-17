querying
vm
	| vm |
	UIManager default
		informUserDuring: [ :bar | 
			bar label: 'Determining Image version'.
			vm := self availableVirtualMachines 
				at: self vmFileName 
				ifAbsent: 
					[ bar 
						label: 'Fetching VM to run Pharo ', self imageVersion , ' images';
						current: 25.
					self fetchVm.
					vm := self availableVirtualMachines at: self vmFileName.
					bar 
						label: 'Fetching sources files for Pharo ', self imageVersion;
						current: 50.
					self fetchSourcesFiles.
					bar 
						label: 'Running the image';
						current: 100.
					vm ]. ].
	^ vm executablePath