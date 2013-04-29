accessing
baseline01: spec
	<version: '0.1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
			spec package: 'Pharo-Launcher-Core' with: [ spec requires: 'XML parsing' ].
			spec package: 'Pharo-Launcher-UI' with: [ spec requires: 'Pharo-Launcher-Core' ].
			
			spec
				project: 'XML parsing'
				with: [ 
					spec
						className: 'ConfigurationOfXMLParser';
						loads: #('Core');
						repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ] ]