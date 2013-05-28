accessing
baseline01: spec
	<version: '0.1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
			spec package: 'Pharo-Launcher-Core' with: [ spec requires: #('XML parsing' 'OSProcess') ].
			spec package: 'Pharo-Launcher-UI' with: [ spec requires: 'Pharo-Launcher-Core Glamour' ].
			spec
				project: 'Glamour'
				with: [ spec className: 'ConfigurationOfGlamour';
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
						repository: 'http://www.squeaksource.com/MetacelloRepository' ] ]