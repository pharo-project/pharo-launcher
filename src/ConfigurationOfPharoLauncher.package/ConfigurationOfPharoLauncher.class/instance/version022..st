versions
version022: spec
	<version: '0.2.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.2'.
		spec author: 'DamienCassou'.
		spec timestamp: '1/8/2015 17:52'.
		spec 
			project: 'XMLParser' with: '1.8.2';
			project: 'OSProcess' with: '4.5.12';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.9'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.66';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-NicolaiHess.35';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
