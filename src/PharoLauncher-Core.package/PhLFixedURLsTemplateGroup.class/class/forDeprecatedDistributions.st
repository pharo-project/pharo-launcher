instance creation
forDeprecatedDistributions
	^ self new
		setName: 'Deprecated distributions'
			Templates:
			 
				{(self pharo40).
					(self pharo30).
					(self pharo20).
					(self moose51).
					(self moose50)};
		isHighlighted: false;
		yourself