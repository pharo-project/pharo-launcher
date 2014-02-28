initialization
initialize
	contextHolder := nil asValueHolder.
	contextHolder whenChangedSend: #updateContext to: self.
	repositoryHolder  := nil asValueHolder.
	commandClasses := Array new.
	super initialize.