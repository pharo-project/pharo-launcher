Extension { #name : #PhLLaunchConfigurationPresenter }

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> clickAddConfigurationButton [
	configurationTable addButton click
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> clickApplyChangesButton [
	applyChangesButton click
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> clickDeleteConfigurationButton [
	configurationTable removeButton click
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> selectConfiguration: aPhLLaunchConfiguration [
	configurationTable selectItem: aPhLLaunchConfiguration
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> selectVm: aPhLVirtualMachine [
	vmList selectItem: aPhLVirtualMachine
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> selectedVm [
	^ vmList selectedItem 
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLLaunchConfigurationPresenter >> vmListItems [
	^ vmList listItems
]
