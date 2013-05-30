updating
update: aDictionary with: aPhLRemoteTemplate 


			aDictionary at: 'url' put: aPhLRemoteTemplate url.
			aDictionary at: 'name' put: aPhLRemoteTemplate name.
			aDictionary at: 'categories' put: aPhLRemoteTemplate categories.
			aDictionary at: 'downloadDate' put: DateAndTime now asString.
			