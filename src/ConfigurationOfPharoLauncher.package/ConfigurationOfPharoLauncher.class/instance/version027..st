versions
version027: spec
	<version: '0.2.7' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.7'.
		spec author: 'DamienCassou'.
		spec timestamp: '4/20/2015 10:02'.
		spec 
			project: 'XMLParser' with: '2.3.0';
			project: 'OSProcess' with: '4.5.13';
			project: 'JSON' with: '1.1';
			project: 'Ston' with: '0.12'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.75';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.40';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
