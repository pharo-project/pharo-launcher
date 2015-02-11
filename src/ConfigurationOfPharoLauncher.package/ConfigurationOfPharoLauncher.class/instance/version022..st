versions
version022: spec
	<version: '0.2.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.2'.
		spec author: 'DamienCassou'.
		spec timestamp: '2/11/2015 16:03'.
		spec 
			project: 'XMLParser' with: '1.9.0';
			project: 'OSProcess' with: '4.5.12';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.10'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.68';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.37';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
