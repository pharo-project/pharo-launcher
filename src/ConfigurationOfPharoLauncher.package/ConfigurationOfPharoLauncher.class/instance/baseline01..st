accessing
baseline01: spec
	<version: '0.1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
			spec package: 'PharoLauncher-Core' with: [ spec requires: #('XML parsing' 'OSProcess' 'JSON') ].
			spec package: 'PharoLauncher-Spec' with: [ spec requires: #('PharoLauncher-Core') ].
			spec package: 'PharoLauncher-Tests-Core' with: [ spec requires: 'PharoLauncher-Core' ].
			self externalDependencies: spec ]