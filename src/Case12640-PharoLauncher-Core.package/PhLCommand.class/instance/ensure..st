private
ensure: aBoolean
	aBoolean ifFalse: [ PhLCommandError signal ]