action
deleteTemplates: someTemplates 
	self dontNotifyDuring: [ someTemplates do: [ :template | self deleteTemplate: template ] ].
	self refresh