Class {
	#name : 'PhLImagesPresenterTest',
	#superclass : 'TestCase',
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#instVars : [
		'presenter',
		'vmStore'
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
PhLImagesPresenterTest >> testImageTableKeepsAlternateRowsColorAfterThemeSwitch [

	| themeClass |
	themeClass := UITheme current class.
	presenter := PhLTestImagesPresenter new.
	presenter application useBackend: #Morphic with: PhLMorphicConfiguration new.
	presenter open.

	[ presenter application switchThemeToDark ]
		ensure: [ themeClass beCurrent ].

	self assert: presenter hasAlternateRowsColor
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

{ #category : 'tests' }
PhLImagesPresenterTest >> testNewImagesIsSelectedWhenNewImageJustCreatedAndImagesSortedByName [
	"Issue #789: the image launched after creation was the first one of the list sorted by name"

	| image |
	presenter := PhLTestImagesPresenter new.
	presenter createImageNamed: 'Bar'.
	presenter application imageRepositoryChanged.
	presenter open.
	presenter clickOnColumnHeaderAt: 1.

	image := PhLImage location: (presenter createImageNamed: 'Zoo').
	presenter application imageRepositoryChanged: image.

	self assert: presenter singleImage name equals: 'Zoo'
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
PhLImagesPresenterTest >> testVmManagerOpenedFromToolbarSelectsVmsToUpdate [

	| vmManager |
	self withInstalledVmsDo: [
		presenter := PhLTestImagesPresenter new.
		presenter showVmUpdates: self vmsToUpdate.

		vmManager := (PhLOpenVmManagerCommand new
			              context: presenter;
			              yourself) newVmManager.

		self
			assertCollection: (vmManager selectedVms collect: [ :each | each id ])
			hasSameElements: #( '130-x64' '120-x64' ) ]
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testVmManagerOpenedFromToolbarWithoutUpdateSelectsNothing [

	| vmManager |
	self withInstalledVmsDo: [
		presenter := PhLTestImagesPresenter new.

		vmManager := (PhLOpenVmManagerCommand new
			              context: presenter;
			              yourself) newVmManager.

		self assertEmpty: vmManager selectedVms ]
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testVmsButtonShowsNumberOfVmsToUpdate [

	| icon badgeColor |
	presenter := PhLTestImagesPresenter new.

	presenter showVmUpdates: self vmsToUpdate.

	icon := presenter vmsButton icon.
	badgeColor := icon colorAt: (icon width - 6) @ 1.
	self assert: (badgeColor red > 0.8 and: [ badgeColor green < 0.3 ]).
	self assert: presenter vmsButton label equals: 'VMs'
]

{ #category : 'tests' }
PhLImagesPresenterTest >> testVmsButtonWithoutVmToUpdate [

	presenter := PhLTestImagesPresenter new.
	presenter showVmUpdates: self vmsToUpdate.

	presenter showVmUpdates: #(  ).

	self assert: presenter vmsButton icon extent equals: PhLOpenVmManagerCommand new icon extent.
	self assert: presenter vmsButton label equals: 'VMs'
]

{ #category : 'accessing' }
PhLImagesPresenterTest >> vmStoreRoot [

	^ vmStore
]

{ #category : 'helpers' }
PhLImagesPresenterTest >> withInstalledVmsDo: aBlock [
	"The VM manager lists the VMs of the VM store"

	vmStore := FileSystem memory root.
	#( '130-x64' '120-x64' '110-x64' ) do: [ :each | self createVmNamed: each ].
	PhLVirtualMachineManager useVmStore: vmStore during: aBlock
]
