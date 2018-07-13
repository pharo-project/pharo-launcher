action
execute
	| templates templateNames confirmMessage answer |
	templates := self model selectedTemplates.
	templateNames := templates collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (templateNames joinUsing: ', ' last: ' and ').
	answer := self model newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer
		ifTrue: [ self model templateRepository deleteTemplates: templates ]