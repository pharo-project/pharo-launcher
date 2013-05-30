instance creation
inriaPharo
	^ self new
			setUrl: 'https://ci.inria.fr/pharo' asZnUrl
			categories: #('Jenkins Pharo')