accessing
longDescription
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'Warning! You are trying to launch a ';
			nextPutAll: imageArchitecture;
			nextPutAll: ' image requiring a ';
			nextPutAll: imageArchitecture;
			nextPutAll: ' VM.';
			nextPut: Character cr;
			nextPutAll: 'Your Pharo Launcher architecture is ';
			nextPutAll: launcherArchitecture;
			nextPutAll: '. You may need to install additional librairies to your system.';
			nextPut: Character cr;
			nextPutAll: 'See https://pharo.org/gnu-linux-installation for more information.' ]