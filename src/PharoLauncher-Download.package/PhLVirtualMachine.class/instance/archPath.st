querying
archPath
	| arch |
	arch := (name last: 3).
	arch = 'x64' ifTrue: [ ^ '64' ].
	^ ''