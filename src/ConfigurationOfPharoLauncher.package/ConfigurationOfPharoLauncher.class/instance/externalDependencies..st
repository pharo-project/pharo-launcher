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
	spec
		project: 'OSProcess'
		with: [ 
			spec
				className: 'ConfigurationOfOSProcess';
				loads: #('Core');
				repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			
	"Please change the #package:with: to a call to #project:with: as soon as there is a ConfigurationOfJSON"
	spec
		package: 'JSON'
		with: [ 
			spec
				repository: 'http://www.smalltalkhub.com/mc/NicolasPetton/JSON/main';
				file: 'JSON-ul.35' ]