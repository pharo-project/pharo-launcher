opening
openPharoOfficial
	^ self new
			setTemplateGroup: PhLRemoteXMLTemplateGroup pharoOfficialGroup imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			open