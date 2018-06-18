cleanup
unsubscribeAllRepositories
	PhLTitledTreeModel allSubInstancesDo: [:c | c repository ifNotNil: [:r | r unsubscribe: c]]