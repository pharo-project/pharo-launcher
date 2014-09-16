cleanup
unsubscribeAllRepositories
	PhLTitledTreeModel allInstancesDo:[:c | c repository unsubscribe: c]