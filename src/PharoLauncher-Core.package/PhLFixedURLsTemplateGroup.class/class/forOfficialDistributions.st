instance creation
forOfficialDistributions
	^ self new
		setName: 'Official distributions'
			Templates: {
				self pharo70_32.
				self pharo70_64.
				self pharo60_32.
				self pharo60_64.
				self pharo50.
				self moose61.
				self moose60
			};
		isHighlighted: true;
		yourself