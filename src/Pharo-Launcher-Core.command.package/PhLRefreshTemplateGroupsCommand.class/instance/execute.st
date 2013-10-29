action
execute
	context templateRepository groups do: [ :group | group refresh; simplifiedTemplatesAndGroups ]