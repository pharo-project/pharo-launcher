versions
version11: spec
	<version: '1.1.1' imports: #('1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1.1
Bux fixes:
  #67 bash is not a command usable under windows
'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '01/20/2018 14:49'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.9';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-VincentBlondeau.170';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.64';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.23'. ].
