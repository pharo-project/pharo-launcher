accessing
template
	^ self meta at: #template ifPresent: [ :t | t name ] ifAbsent: [ #unknown ]