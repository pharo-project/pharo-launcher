updating
refreshTemplateGroups
	PhLDownloadManager default reset. 
	self showDownloadInProgress.
	UIManager default informUserDuring: 
	[	:outerBar |  
		outerBar label: 'Refreshing Template Groups'.
		templateRepository groups do: 
		[	:group | 
			UIManager default informUserDuring: 
			[	:groupBar |  
				[	group refresh.
					group simplifiedTemplatesAndGroups 
				]	on: HTTPProgress do: 
					[	:progress |
						groupBar label: '''' , group name , '''  ' , progress printString. 	
						progress resume
					].
			].
		].
		templatesModel roots: templateRepository groups
	].
	self showNumberOfErrors.