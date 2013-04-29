as yet unclassified
openLocal: anURL
	| defaultTab webTab otherTab existingTab associations tc  |
	
	defaultTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Default' ) selectCategory: 'Default'.
	webTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Web') selectCategory: 'Web'.
	otherTab := PharoLauncherTabUI open: (PharoLauncherModel category: 'Other') selectCategory: 'Other'.
	existingTab := PharoLauncherTabUI open: (PharoLauncherModelExistingImage category: 'Existing' url: anURL) selectCategory: 'Existing'.
	
	associations := {'Default' -> defaultTab. 'Web'-> webTab. 'Other'-> otherTab. 'Existing'-> existingTab}.
	tc := self associations: associations. 
	tc open