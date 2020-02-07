Class {
	#name : #PhLLaunchConfigurationPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'image',
		'application'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #accessing }
PhLLaunchConfigurationPresenterTest >> defaultTimeLimit [
	^ 20 seconds
]

{ #category : #running }
PhLLaunchConfigurationPresenterTest >> setUp [
	image := PhLImage example.
	image versionFile writeStreamDo: [ :s | s nextPutAll: '80' ].
	self setUpPresenter
]

{ #category : #running }
PhLLaunchConfigurationPresenterTest >> setUpPresenter [
	self setUpPresenterWithApplication: PhLTestApplication new.

]

{ #category : #running }
PhLLaunchConfigurationPresenterTest >> setUpPresenterWithApplication: anSpApplication [
	presenter := PhLLaunchConfigurationPresenter
		             newApplication: anSpApplication
		             model: image
]

{ #category : #running }
PhLLaunchConfigurationPresenterTest >> tearDown [ 
	presenter window ifNotNil: #close
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testCanOpenAPresenterWithVMNotInDefaultListNorOnDisk [
	| config |
	config := (PhLLaunchConfiguration withImage: image)
				name: 'test config';
				vm: (PhLVirtualMachine id: '01-x86')
				yourself.
	image addLaunchConfiguration: config.
	self setUpPresenter.
	presenter initializeVmListContent.

	self assert: (presenter vmListItems noneSatisfy: [ :each | each id = config vm id]). "ensure we test with vm not listed in presenter"
	presenter selectConfiguration: config.
	
	self 
		assert: presenter selectedVm id 
		equals: config vm id
	
	
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testEditingAndSavingAConfigurationSelectsItInImagesPresenterToolbar [
	| config imagesPresenter |
	imagesPresenter := PhLTestImagesPresenter new.
	image := imagesPresenter singleImage.
	image launchConfigurations. "generate default configuration"
	config := (PhLLaunchConfiguration withImage: image)
				name: 'test config';
				yourself.
	image addLaunchConfiguration: config.
	presenter application imagesPresenter: imagesPresenter.
	imagesPresenter 
		openWithSpec;
		selectImageAt: 1.
	self setUpPresenterWithApplication: imagesPresenter application.
	presenter connectPresenters. "Select first config"
	self 
		assert: imagesPresenter selectedLaunchConfiguration name
		equals: 'Default'.
			
	presenter selectConfiguration: config.
	presenter saveSelectedConfiguration.
	
	self 
		assert: imagesPresenter selectedLaunchConfiguration name
		equals: config name.
	imagesPresenter delete.
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testImageLaunchConfigurationsUpdatedWhenConfigurationAdded [
	self setUpPresenter.
	application requestAnswer: 'foo'.
	self
		assert: image launchConfigurations size 
		equals: 1. "Default"
		
	presenter clickAddConfigurationButton.
		
	self
		assert: image launchConfigurations size 
		equals: 2. "Default foo"
	self
		assert: image launchConfigurations second name
		equals: 'foo'.
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testImageLaunchConfigurationsUpdatedWhenConfigurationRemoved [
	| configuration |
	configuration := (PhLLaunchConfiguration withImage: presenter image)
		                 name: 'foo';
		                 yourself.
	image addLaunchConfiguration: configuration.
	self setUpPresenter.
	self
		assert: image launchConfigurations size 
		equals: 2. "Default + foo"

	presenter
		selectConfiguration: configuration;
		clickDeleteConfigurationButton.
		
	self
		assert: image launchConfigurations size 
		equals: 1.
	self
		assert: image launchConfigurations first name
		equals: PhLLaunchConfiguration defaultName.
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testVmsAreSortedById [
	| vms sortedVms |
	self setUpPresenter.
	presenter initializeVmListContent.
	
	vms := presenter vmListItems.
	sortedVms := vms sorted: [ :a :b | a id > b id ].
	
	vms withIndexDo: [ :vm :index |
		self assert: vm id equals: (sortedVms at: index) id ].
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testWhenOpeningPresenterThenSelectedConfigurationIsDefaultConfiguration [
	self setUpPresenter.

	self deny: presenter selectedConfiguration isNil.
	self 
		assert: presenter selectedConfiguration name
		equals: 'Default'
]
