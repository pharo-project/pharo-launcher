instance creation
forCommonTools
	^ self new
		setName: 'Common tools'
			Templates:
				{
				(self pharo50).
				(self pharo40).
				(self pharo30).
					(self pharo20).
					(self moose49).
					(self moose50). (self moose51)};
		isHighlighted: true;
		yourself