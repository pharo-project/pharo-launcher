accessing
baseline01: spec
	<version: '0.1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
			spec package: 'Pharo-Launcher-Core' with: [ spec requires: #('XML parsing' 'OSProcess' 'JSON') ].
			spec package: 'Pharo-Launcher-UI' with: [ spec requires: #('Pharo-Launcher-Core') ].
			spec package: 'Pharo-Launcher-Tests' with: [ spec requires: 'Pharo-Launcher-Core' ].
			self externalDependencies: spec ]