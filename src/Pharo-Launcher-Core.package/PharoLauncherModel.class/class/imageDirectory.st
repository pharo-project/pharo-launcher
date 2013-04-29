path-directory
imageDirectory
	^ (StartupLoader preferencesGeneralFolder asFileReference / 'launcher')
			ensureDirectory;
			yourself