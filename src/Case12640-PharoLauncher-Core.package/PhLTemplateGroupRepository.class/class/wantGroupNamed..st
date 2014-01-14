private
wantGroupNamed: aString
	^ self groups at: (self allGroups detect: [:group | group name = aString ])