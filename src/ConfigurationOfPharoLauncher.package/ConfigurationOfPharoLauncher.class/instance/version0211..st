versions
version0211: spec
	<version: '0.2.11' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.11
PharoLauncher now runs on top of Pharo 5.0 and is now shipped with both V3 anf Spur VM.
Add support to easily run Pharo 6.0 images.
PharoLauncher now embed th latest pharo stable image for off-line use.
Better display of Jenkins jobs.'.
		spec author: 'ChristopheDemarey'.
		spec timestamp: '5/18/2016 09:25'.
		spec 
			project: 'XMLParser' with: '2.7.6';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.19'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.102';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.47';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.11'. ].
