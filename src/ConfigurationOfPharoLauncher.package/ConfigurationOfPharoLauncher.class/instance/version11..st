versions
version11: spec
	<version: '1.1' imports: #('1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1
New features:
 #66 new command: import an image into the launcher default image folder 
 #65 new command: remove a template from "Downloaded templates"
 #64 new command: create a local template from an image and remove the image
 #57 new option: run an image from a login shell to inherit from shell startup scripts to set up environment variables.
 #54 It is now possible to run an image anywhere on your file system if you click "launch" and no image is selected
 #23 Pharo Launcher now has an "about" box giving its description, version and a link to the bug tracker.
Improvements:
 #62 Pharo Launcher should not load default Pharo settings 
 #51 Pharo Launcher now sets the current directory to the directory containing the image (was the VM directory). Avoid confusions in Pharo 7 images.
Bux fixes:
 #60 hardReset option causes troubles to PharoLauncher 
 #56 #, was sent to nil
 #55 Display name of Pharo 7 images unusable 
 #52 Cannot open a Pharo 2 image
 #47 Cannot run pharo 50 pre-Spur images
'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '01/16/2018 08:19'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.9';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.168';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.64';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.23'. ].
