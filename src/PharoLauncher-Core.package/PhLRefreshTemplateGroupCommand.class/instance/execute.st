action
execute
	context selectedTemplateGroups do: [ :group | group refresh ].
	context templateRepositoryChanged