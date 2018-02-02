initialization
setCommand: aCommandString
	command := aCommandString reject: [ :c | c = Character cr ] "easier to run the copy/pasted command in a shell if command has only one line"