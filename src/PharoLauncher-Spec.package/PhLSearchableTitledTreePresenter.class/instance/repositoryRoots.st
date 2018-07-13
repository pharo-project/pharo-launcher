private - accessing
repositoryRoots

	^regexMatcher isNil ifTrue: [ self repository roots ]
					    ifFalse: [ self repository roots select: [ :each| regexMatcher search: each name asString ]] 