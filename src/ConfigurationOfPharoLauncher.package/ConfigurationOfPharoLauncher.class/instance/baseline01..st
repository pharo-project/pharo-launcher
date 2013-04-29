accessing
baseline01: spec
	<version: '0.1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
			spec package: 'Pharo-Launcher-Core' with: [ spec requires: #('XML parsing' 'OSProcess') ].
			spec package: 'Pharo-Launcher-UI' with: [ spec requires: 'Pharo-Launcher-Core' ].
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
						repository: 'http://www.squeaksource.com/MetacelloRepository' ] ]