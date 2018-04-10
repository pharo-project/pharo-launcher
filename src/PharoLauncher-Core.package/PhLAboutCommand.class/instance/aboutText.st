accessing
aboutText
	^ String streamContents: [:stream |
		stream
			<< 'Pharo Launcher is a tool that ease the management of Pharo images and their associated Virtual Machines. It can download official Pharo images from the Pharo repository, fetch the right virtual machine to run your image and many other things.';
			cr;
			<< 'If you find a bug, please open an issue at https://github.com/pharo-project/pharo-launcher/issues.';
			cr; cr;
			<< 'Pharo Launcher version: ';
			<< self launcherVersion;
			cr;
			<< 'Packages :';
			cr;
			<< '- ';
			<< ((String cr , '- ') join: self launcherPackageList) ]
	