private
update: aDictionary with: aRemoteTemplate 


			aDictionary at: 'url' put: aRemoteTemplate url asString.
			aDictionary at: 'name' put: aRemoteTemplate name.
			aDictionary at: 'downloadDate' put: DateAndTime now asString.
			