cleanup
unsubscribeAllRepositories
	PhLTitledTreeModel allSubInstancesDo: [:c | c repository unsubscribe: c]