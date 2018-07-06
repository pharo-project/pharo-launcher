versions
version025: spec
	<version: '0.2.5' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.5, Pharo5'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '2/13/2015 11:15'.
		spec 
			project: 'XMLParser' with: '1.9.0';
			project: 'OSProcess' with: '4.5.12';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.10'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-TorstenBergmann.72';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-TorstenBergmann.38';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
