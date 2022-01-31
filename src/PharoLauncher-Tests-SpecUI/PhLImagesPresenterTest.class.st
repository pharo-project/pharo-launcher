Class {
	#name : #PhLImagesPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #running }
PhLImagesPresenterTest >> tearDown [
	presenter window ifNotNil: #close.
	super tearDown
]

{ #category : #tests }
PhLImagesPresenterTest >> testFirstImageIsSelectedAtOpening [

	presenter := PhLTestImagesPresenter new.
	presenter open.

	self assert: presenter hasSingleImageSelected.
	self
		assert: presenter singleImage name
		equals: presenter singleImageName
]

{ #category : #tests }
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

{ #category : #tests }
PhLImagesPresenterTest >> testImageLaunchConfigurationsIsUpdatedAfterSortingOfImages [

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

{ #category : #tests }
PhLImagesPresenterTest >> testImagesPresenterIsRefreshedWhenApplicationNotifyImageRepositoryChanged [

	presenter := PhLTestImagesPresenter new.
	presenter open.

	presenter createImageNamed: 'Foo'.
	presenter application imageRepositoryChanged.

	self
		assertCollection: presenter imageNames
		hasSameElements: #( 'TestImage' 'Foo' )
]

{ #category : #tests }
PhLImagesPresenterTest >> testLaunchCommandIsDisabledWhenNoSelection [

	| enabled |
	presenter := PhLTestImagesPresenter new.
	presenter
		open;
		unselectAll.

	presenter withToolbarDo: [ :toolbar | 
		presenter toolbarGroup allCommands
			detect: [ :cmd | cmd name = 'Launch' ]
			ifFound: [ :cmd | enabled := cmd presenter isEnabled ] ].
	self deny: enabled
]

{ #category : #tests }
PhLImagesPresenterTest >> testNewImagesIsSelectedWhenNewImageJustCreated [

	| image |
	presenter := PhLTestImagesPresenter new.
	presenter open.

	image := PhLImage location: (presenter createImageNamed: 'Foo').
	presenter application imageRepositoryChanged: image.

	self assert: presenter singleImage name equals: 'Foo'
]
