action
executeOrInform
	self isApplicable
		ifTrue: [ 
			self execute.
			self informMigrationDone ]
		ifFalse: [ self informManualMigrationNeeded ]