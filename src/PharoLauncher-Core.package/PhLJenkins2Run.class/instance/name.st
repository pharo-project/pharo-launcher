accessing
name
	^ String streamContents: [ :stream | self url jenkinsOptions printElementsOn: stream ]