actions
removeFromSystem
	| vmFolder zipFile |
	vmFolder := self vmStore / self name.
	vmFolder exists
		ifTrue: [ vmFolder ensureDeleteAll ].
	zipFile := self vmStore / (self name, '.zip').
	zipFile exists
		ifTrue: [ zipFile ensureDelete ].
