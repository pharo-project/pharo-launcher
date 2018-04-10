private
updateTemplateDescription: templateDescription with: aRemoteTemplate
	templateDescription at: 'url' put: aRemoteTemplate url asString.
	templateDescription at: 'name' put: aRemoteTemplate name.
	templateDescription at: 'downloadDate' put: DateAndTime now asString