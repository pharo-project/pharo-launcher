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
			
	"Please change the #package:with: to a call to #project:with: as soon as there is a ConfigurationOfJSON"
	spec
		project: 'JSON'
		with: [ 
			spec
				className: 'ConfigurationOfJSON';
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main'].
	spec
		project: 'STON'
		with: [ 
			spec
				className: 'ConfigurationOfSton';
				versionString: #stable;
				repository: 'http://ss3.gemstone.com/ss/STON' ]