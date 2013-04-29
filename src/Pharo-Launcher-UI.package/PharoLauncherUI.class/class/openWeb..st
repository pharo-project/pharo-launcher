as yet unclassified
openWeb: anURL
	| defaultTab webTab otherTab existingTab associations tc  yourTab |
	
	defaultTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Default') selectCategory: 'Default'.
	webTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Web') selectCategory: 'Web'.
	otherTab := PharoLauncherTabUI open: (PharoLauncherModel category: 'Other') selectCategory: 'Other'.
	existingTab := PharoLauncherTabUI open: (PharoLauncherModelExistingImage category: 'Existing') selectCategory: 'Existing'.	
	yourTab := PharoLauncherTabUI open: (PharoLauncherModelExistingImage category: 'workspace' url: anURL ) selectCategory: 'Local workspace'.
	associations := {'Default' -> defaultTab. 'Web'-> webTab. 'Other'-> otherTab. 'Existing'-> existingTab. 'Personnal URL'-> yourTab}.
	tc := self associations: associations. 
	tc open