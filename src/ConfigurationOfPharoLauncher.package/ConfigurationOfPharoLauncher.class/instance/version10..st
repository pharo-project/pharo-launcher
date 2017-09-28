versions
version10: spec
	<version: '1.0' imports: #('1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0
Add a VM management utility able to find (and download) the appropriate VM for a given image. So, the launcher is not shipped anymore with an extra VM.
Pharo Launcher files (images, VMs) are now considered as user Documents. Consequently, they are now stored in the standard documents folder of the OS except for Linux, lancher files are stored in the $HOME directory'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '9/29/2017 14:20'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.134';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.52';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.19'. ].
