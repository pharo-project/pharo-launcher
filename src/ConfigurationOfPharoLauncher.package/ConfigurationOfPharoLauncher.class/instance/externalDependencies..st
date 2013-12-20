accessing
externalDependencies: spec
	spec
		project: 'XML parsing'
		with: [ 
			spec
				className: 'ConfigurationOfXMLParser';
				loads: #('Core');
				repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
	spec
		project: 'OSProcess'
		with: [ 
			spec
				className: 'ConfigurationOfOSProcess';
				loads: #('Core');
				repository: 'http://www.squeaksource.com/MetacelloRepository' ].
	
		spec
		project: 'Zinc'
		with: [ 
			spec
				className: 'ConfigurationOfZincHTTPComponents';
				loads: #('Zinc-HTTP');
				repository: 'http://www.squeaksource.com/ZincHTTPComponents' ].
	
	"Please change the #package:with: to a call to #project:with: as soon as there is a ConfigurationOfJSON"
	spec
		package: 'JSON'
		with: [ 
			spec
				repository: 'http://www.smalltalkhub.com/mc/NicolasPetton/JSON/main';
				file: 'JSON-ul.35' ].
			
	spec
		project: 'STON'
		with: [ 
			spec
				className: 'ConfigurationOfSton';
				versionString: #stable;
				repository: 'http://ss3.gemstone.com/ss/STON' ].
