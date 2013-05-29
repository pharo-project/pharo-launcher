accessing
externalDependencies: spec
	spec
		project: 'Glamour'
		with: [ 
			spec
				className: 'ConfigurationOfGlamour';
				version: #development;
				loads: #('Core' 'Morphic');
				repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
	spec
		project: 'XML parsing'
		with: [ 
			spec
				className: 'ConfigurationOfXMLParser';
				loads: #('Core');
				repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
	^ spec
		project: 'OSProcess'
		with: [ 
			spec
				className: 'ConfigurationOfOSProcess';
				loads: #('Core');
				repository: 'http://www.squeaksource.com/MetacelloRepository' ]