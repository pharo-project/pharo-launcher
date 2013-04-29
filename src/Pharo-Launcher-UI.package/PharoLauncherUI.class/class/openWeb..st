as yet unclassified
openWeb: anURL
	| defaultTab webTab otherTab existingTab associations tc  |
	
	defaultTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Default' url: anURL) selectCategory: 'Default'.
	webTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Web' url: anURL) selectCategory: 'Web'.
	otherTab := PharoLauncherTabUI open: (PharoLauncherModel category: 'Other' url: anURL) selectCategory: 'Other'.
	existingTab := PharoLauncherTabUI open: (PharoLauncherModelExistingImage category: 'Existing') selectCategory: 'Existing'.
	
	associations := {'Default' -> defaultTab. 'Web'-> webTab. 'Other'-> otherTab. 'Existing'-> existingTab}.
	tc := self associations: associations. 
	tc open