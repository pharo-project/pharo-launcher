instance creation
forCommonTools
	^ self new
		setName: 'Common tools'
			Templates:
				{(self pharo30).
					(self pharo20).
					(self pharo14).
					(self moose49)};
		isHighlighted: true;
		yourself