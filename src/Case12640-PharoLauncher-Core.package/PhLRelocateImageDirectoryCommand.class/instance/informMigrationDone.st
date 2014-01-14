user interaction
informMigrationDone
	PhLUIInformation new
		message:
				('Migration of your images from {1} to {2} done'
						format:
							{(self source pathString).
							(self target pathString)});
		inform