versions
version020: spec
	<version: '0.2.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.0'.
		spec author: 'DamienCassou'.
		spec timestamp: '9/14/2014 21:23'.
		spec 
			project: 'XMLParser' with: '1.6.5';
			project: 'OSProcess' with: '4.5.8';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.9'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.63';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-TimMackinnon.34';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
