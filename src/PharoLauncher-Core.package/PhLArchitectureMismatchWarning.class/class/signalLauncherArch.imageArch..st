signalling
signalLauncherArch: launcherArchitecture imageArch: imageArchitecure 
	^ self new
		initializeWith: launcherArchitecture imageArch: imageArchitecure;
		signal