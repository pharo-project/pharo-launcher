cleanup
unsubscribeAllRepositories
	PhLTitledTreePresenter allSubInstancesDo: [:c | c repository ifNotNil: [:r | r unsubscribe: c]]