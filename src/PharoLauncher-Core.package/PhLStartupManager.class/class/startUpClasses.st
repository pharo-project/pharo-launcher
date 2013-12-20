accessing
startUpClasses
	^ StartUpClasses ifNil: [ StartUpClasses := SortedCollection sortBlock: [ :c1 :c2 | c1 startUpPriority < c2 startUpPriority ] ]