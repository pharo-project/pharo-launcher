versions
version028: spec
	<version: '0.2.8' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.8'.
		spec author: 'DamienCassou'.
		spec timestamp: '8/8/2015 07:55'.
		spec 
			project: 'XMLParser' with: '2.4.9';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.1';
			project: 'Ston' with: '0.14'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-SeanDeNigris.78';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.40';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
