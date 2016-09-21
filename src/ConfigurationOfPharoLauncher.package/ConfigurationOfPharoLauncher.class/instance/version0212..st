versions
version0212: spec
	<version: '0.2.12' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.12
Run on Pharo 5.0. Fixes the browse folder problem on Windows and added a filter for the images'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '5/18/2016 09:25'.
		spec 
			project: 'XMLParser' with: '2.7.6';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.19'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-TorstenBergmann.103';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-TorstenBergmann.48';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.11'. ].
