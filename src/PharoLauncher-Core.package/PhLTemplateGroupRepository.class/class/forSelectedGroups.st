instance creation
forSelectedGroups
	^ self newFromGroups: (self allGroups select: [ :group | self wantGroupNamed: group name ])