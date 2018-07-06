action
execute
	| templates templateNames confirmMessage answer |
	templates := context selectedTemplates.
	templateNames := templates collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (templateNames joinUsing: ', ' last: ' and ').
	answer := context newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer
		ifTrue: [ context templateRepository deleteTemplates: templates ]