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
