versions
version13: spec
	<version: '1.3' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.3
Improvements:
	#129 Warning that appear everytime when you run a 32 bits image in a 64 bits VM PharoLauncher'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '06/21/2018 15:05'.
		spec 
			project: 'XMLParser' with: '3.5.0';
			project: 'OSProcess' with: '4.6.13';
			project: 'ProcessWrapper' with: '1.2';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.198';
			package: #'PharoLauncher-Download' with: 'PharoLauncher-Download-ChristopheDemarey.13';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-CyrilFerlicot.71';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.25';
			package: #'PharoLauncher-Tests-Download' with: 'PharoLauncher-Tests-Download-ChristopheDemarey.4'. ].