Class {
	#name : #BaselineOfPharoLauncherCli,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoLauncherCli
}

{ #category : #baseline }
BaselineOfPharoLauncherCli >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			"dependencies"
			self baselineOfClap: spec.
			
			"Packages" 
			spec 
				package: 'PharoLauncher-cli-restructured' with: [ spec requires: #('Clap')];
				package: 'PharoLauncher-cli-restructured-Tests' with: [ spec requires: #('PharoLauncher-cli-restructured') ].

			"groups"
			spec
				group: 'default' with: #('Development');
				group: 'Tests' with: 'PharoLauncher-cli-restructured-Tests';
				group: 'Deployment' with: 'PharoLauncher-cli-restructured';
				group: 'Development' with: #('Deployment' 'Tests')
		]
]

{ #category : #baseline }
BaselineOfPharoLauncherCli >> baselineOfClap: spec [
	spec
		baseline: 'Clap'
		with: [ spec repository: 'github://cdlm/clap-st/src' ]
]
