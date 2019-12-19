Extension { #name : #PhLLaunchConfigurationPresenter }

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> clickAddConfigurationButton [
	configurationTable addButton click
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> clickDeleteConfigurationButton [
	configurationTable removeButton click
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> selectConfiguration: aPhLLaunchConfiguration [
	configurationTable selectItem: aPhLLaunchConfiguration
]
