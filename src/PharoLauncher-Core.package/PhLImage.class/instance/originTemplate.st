accessing
originTemplate

	^ self meta at: #template ifAbsent: [ nil ]