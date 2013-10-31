updating
update
	self context
		ifNotNil: [ :context | 
			command := commandClass on: context.
			self enabled: command isApplicable ]