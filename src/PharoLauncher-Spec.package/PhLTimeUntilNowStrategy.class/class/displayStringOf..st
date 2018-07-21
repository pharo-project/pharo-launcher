accessing
displayStringOf: aDateAndTime
	^ (DateAndTime now - aDateAndTime) simpleTimeAgo asText