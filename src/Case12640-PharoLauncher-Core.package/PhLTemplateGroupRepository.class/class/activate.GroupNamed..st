private
activate: aBoolean GroupNamed: aString
	^ self groups at: (self allGroups detect: [ :group | group name = aString ]) put: aBoolean