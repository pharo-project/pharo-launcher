helpers
configuration
	^ configuration ifNil: [ configuration := PRExportConfiguration new ]