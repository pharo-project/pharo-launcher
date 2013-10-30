initialization
initialize
	super initialize.
	contextHolder := nil asValueHolder.
	contextHolder whenChangedSend: #update to: self.