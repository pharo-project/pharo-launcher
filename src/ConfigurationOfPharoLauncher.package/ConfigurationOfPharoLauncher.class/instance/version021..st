versions
version021: spec
	<version: '0.2.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.1'.
		spec author: 'BenComan'.
		spec timestamp: '9/22/2014 23:50'.
		spec 
			project: 'XMLParser' with: '1.6.5';
			project: 'OSProcess' with: '4.5.8';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.9'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-NicolaiHess.64';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-NicolaiHess.35';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].
