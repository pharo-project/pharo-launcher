versions
version029: spec
	<version: '0.2.9' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.9'.
		spec author: 'StephanEggermont'.
		spec timestamp: '13/1/2016 16:40'.
		spec 
			project: 'XMLParser' with: '2.5.6';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.15'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-StephanEggermont.87';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-CyrilFerlicot.42';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
