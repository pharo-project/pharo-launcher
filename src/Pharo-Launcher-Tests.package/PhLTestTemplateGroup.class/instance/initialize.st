initialize-release
initialize
	templates := OrderedCollection new.
	templates add: (PhLTestTemplate new setName: 't1' categories: #('c1' 'c2')).
	templates add: (PhLTestTemplate new setName: 't2' categories: #('c2' 'c3')).
	templates add: (PhLTestTemplate new setName: 't3' categories: #('c1' 'c3')).