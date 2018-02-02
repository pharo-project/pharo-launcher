versions
version101: spec
	<version: '1.0.1' imports: #('1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1
Avoid to scan unattended folders when using VM shipped with the launcher.
Overwrite files when downloading or unzipping.
Catch NotFound error and give better error message.
Fix issue 21: cannot detect unzip availability on windows'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '10/05/2017 12:19'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.139';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.53';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.19'. ].
