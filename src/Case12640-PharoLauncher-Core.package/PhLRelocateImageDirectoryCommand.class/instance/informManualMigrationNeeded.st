user interaction
informManualMigrationNeeded
	PhLUIInformation new
		message:
				('You need to manually relocate your images from {1} to {2}'
						format:
							{(self source pathString).
							(self target pathString)});
		inform