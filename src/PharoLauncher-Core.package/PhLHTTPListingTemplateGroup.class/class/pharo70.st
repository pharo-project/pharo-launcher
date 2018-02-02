instance creation
pharo70
	^ self 
		name: 'Pharo 7.0 (development version)' 
		url: 'http://files.pharo.org/image/70/' asZnUrl
		filterPattern: 'href="(Pharo-7.0.0-alpha.build.[^"]*.zip)"'