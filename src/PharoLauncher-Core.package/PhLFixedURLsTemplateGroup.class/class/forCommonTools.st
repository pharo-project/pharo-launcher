instance creation
forCommonTools
	^ self new
		setName: 'Common tools'
			Templates:
				{	(self pharo60).
					(self pharo50).
					(self pharo40).
					(self pharo30).
					(self pharo20).
					(self moose60).
					(self moose51).
					(self moose50)};
		isHighlighted: true;
		yourself