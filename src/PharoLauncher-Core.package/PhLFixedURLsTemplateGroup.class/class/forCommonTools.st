instance creation
forCommonTools
	^ self new
		setName: 'Common tools'
			Templates:
				{(self pharo30).
					(self pharo20).
					(self moose49).
					(self moose50)};
		isHighlighted: true;
		yourself