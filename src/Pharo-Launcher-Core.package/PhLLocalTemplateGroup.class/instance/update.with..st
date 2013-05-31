updating
update: aDictionary with: aRemoteTemplate 


			aDictionary at: 'url' put: aRemoteTemplate url asString.
			aDictionary at: 'name' put: aRemoteTemplate name.
			aDictionary at: 'categories' put: aRemoteTemplate categories.
			aDictionary at: 'downloadDate' put: DateAndTime now asString.
			