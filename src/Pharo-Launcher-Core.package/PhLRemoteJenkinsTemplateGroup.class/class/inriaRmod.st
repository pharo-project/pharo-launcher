instance creation
inriaRmod
	^ self new
			setUrl: 'https://ci.inria.fr/rmod' asZnUrl
			categories: #('Jenkins RMoD')