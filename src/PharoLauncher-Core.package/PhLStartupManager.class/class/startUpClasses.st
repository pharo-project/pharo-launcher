accessing
startUpClasses
	^ StartUpClasses
		ifNil: [ StartUpClasses := SortedCollection sortBlock: [ :c1 :c2 | c1 launcherStartUpPriority < c2 launcherStartUpPriority ] ]