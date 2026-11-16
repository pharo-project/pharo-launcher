Class {
	#name : 'PhLImagesPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'running' }
PhLImagesPresenterTest >> tearDown [
	presenter ifNotNil: [ 
		presenter window ifNotNil: [ :window | window close] ].
	super tearDown
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testCommandsApplyingOnAnImageAreDisabledWhenNoSelection [

	presenter := PhLTestImagesPresenter new.
	presenter
		open;
		unselectAll.

	presenter imageActionButtons do: 
		[ :button |
		self deny: button isEnabled ]
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testCommandsApplyingOnAnImageAreEnabledWhenImageSelected [

	presenter := PhLTestImagesPresenter new.
	
	presenter open.
	
	self assert: presenter hasSingleImageSelected.
	presenter imageActionButtons do: 
		[ :button |
		self assert: button isEnabled ]
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testFirstImageIsSelectedAtOpening [

	presenter := PhLTestImagesPresenter new.
	presenter open.

	self assert: presenter hasSingleImageSelected.
	self
		assert: presenter singleImage name
		equals: presenter singleImageName
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testImageLaunchConfigurationsAreUpdatedAfterLaunchConfigurationEdition [

	| launchConfigurationPresenter |
	
	self skip: 'need to handle modal presenter to run this test'.
	
	presenter := PhLTestImagesPresenter new.
	presenter
		open;
		selectImageAt: 1.

	self assert: presenter launchConfigurations size equals: 1.

	launchConfigurationPresenter := presenter editLaunchConfigurations.
	presenter singleImage addLaunchConfiguration:
		((PhLLaunchConfiguration withImage: presenter singleImage)
			 name: 'foo';
			 yourself).
	launchConfigurationPresenter clickApplyChangesButton.
	launchConfigurationPresenter window close.

	self assert: presenter launchConfigurations size equals: 2
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testImageLaunchConfigurationsIsUpdatedAfterSortingOfImages [

	self skip: 'Sorting is not yet available on GTK'.
	presenter := PhLTestImagesPresenter new.
	presenter createImageNamed: 'Zoo'.
	presenter application imageRepositoryChanged.
	presenter
		open;
		selectImageAt: 1.

	presenter
		clickOnColumnHeaderAt: 1;
		selectImageAt: 1.

	self assert: presenter singleImage name equals: 'TestImage'.
	self
		assert: presenter launchConfigurations first image name
		equals: 'TestImage'
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testImagesPresenterIsRefreshedWhenApplicationNotifyImageRepositoryChanged [

	presenter := PhLTestImagesPresenter new.
	presenter open.

	presenter createImageNamed: 'Foo'.
	presenter application imageRepositoryChanged.

	self
		assertCollection: presenter imageNames
		hasSameElements: #( 'TestImage' 'Foo' )
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testNewImagesIsSelectedWhenNewImageJustCreated [

	| image |
	presenter := PhLTestImagesPresenter new.
	presenter open.

	image := PhLImage location: (presenter createImageNamed: 'Foo').
	presenter application imageRepositoryChanged: image.

	self assert: presenter singleImage name equals: 'Foo'
]

{ #category : 'helpers' }
PhLImagesPresenterTest >> vmsToUpdate [

	^ {
		  (PhLVirtualMachine new
			   id: '130-x64';
			   yourself).
		  (PhLVirtualMachine new
			   id: '120-x64';
			   yourself) }
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testVmManagerOpenedFromToolbarProposesUpdateOfVmsToUpdate [

	| vmManager |
	presenter := PhLTestImagesPresenter new.
	presenter showVmUpdates: self vmsToUpdate.

	vmManager := (PhLOpenVmManagerCommand new
		              context: presenter;
		              yourself) newVmManager.

	self assert: vmManager notice isVisible
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testVmManagerOpenedFromToolbarWithoutUpdateHasNoNotice [

	| vmManager |
	presenter := PhLTestImagesPresenter new.

	vmManager := (PhLOpenVmManagerCommand new
		              context: presenter;
		              yourself) newVmManager.

	self deny: vmManager notice isVisible
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testVmsButtonShowsNumberOfVmsToUpdate [

	presenter := PhLTestImagesPresenter new.

	presenter showVmUpdates: self vmsToUpdate.

	self assert: presenter vmsButton label equals: 'VMs (2)'
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testVmsButtonWithoutVmToUpdate [

	presenter := PhLTestImagesPresenter new.
	presenter showVmUpdates: self vmsToUpdate.

	presenter showVmUpdates: #(  ).

	self assert: presenter vmsButton label equals: 'VMs'
]
