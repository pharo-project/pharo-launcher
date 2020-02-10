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
	presenter window ifNotNil: #close
]

{ #category : #tests }
PhLImagesPresenterTest >> testImageLaunchConfigurationsAreUpdatedAfterLaunchConfigurationEdition [
	| launchConfigurationPresenter |
	presenter := PhLTestImagesPresenter new. 
	presenter 
		openWithSpec;
		selectImageAt: 1.
	
	self
		assert: presenter launchConfigurations size
		equals: 1.
	
	launchConfigurationPresenter := presenter editLaunchConfigurations.
	presenter singleImage 
		addLaunchConfiguration: (
			(PhLLaunchConfiguration withImage: presenter singleImage) 
				name: 'foo';
				yourself).
	launchConfigurationPresenter clickApplyChangesButton.
	launchConfigurationPresenter window close.
		
	self
		assert: presenter launchConfigurations size
		equals: 2.
]

{ #category : #tests }
PhLImagesPresenterTest >> testImagesPresenterIsRefreshedWhenApplicationNotifyImageRepositoryChanged [
	presenter := PhLTestImagesPresenter new. 
	presenter openWithSpec.
	
	presenter createImageNamed: 'Foo'.
	presenter application imageRepositoryChanged.
	
	self
		assertCollection: presenter imageNames
		hasSameElements: #('TestImage' 'Foo').
]
