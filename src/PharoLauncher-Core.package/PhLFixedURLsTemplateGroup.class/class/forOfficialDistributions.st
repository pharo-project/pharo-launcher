instance creation
forOfficialDistributions
	^ self new
		setName: 'Official distributions'
			Templates:
			 
				{  (self pharo70).	
					(self pharo60).
					(self pharo50).
					(self moose61).
					(self moose60)};
		isHighlighted: true;
		yourself