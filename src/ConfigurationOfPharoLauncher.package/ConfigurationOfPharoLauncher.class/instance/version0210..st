versions
version0210: spec
	<version: '0.2.10' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.10'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '1/14/2016 10:45'.
		spec 
			project: 'XMLParser' with: '2.5.7';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.15'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-CyrilFerlicot.88';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-VincentBlondeau.44';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
