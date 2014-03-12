as yet unclassified
name
	^ String streamContents: [ :stream | self url jenkinsOptions printElementsOn: stream ]