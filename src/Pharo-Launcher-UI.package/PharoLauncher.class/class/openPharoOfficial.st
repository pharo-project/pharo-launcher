opening
openPharoOfficial
	^ self new
			setTemplateGroup: PhLRemoteXMLLauncherTemplateGroup pharoOfficialGroup imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			open