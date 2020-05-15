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
	super setUp.
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
	application := anSpApplication.
	presenter := PhLLaunchConfigurationPresenter
		             newApplication: anSpApplication
		             model: image
]

{ #category : #running }
PhLLaunchConfigurationPresenterTest >> tearDown [
	presenter window ifNotNil: #close.
	super tearDown
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
PhLLaunchConfigurationPresenterTest >> testConfigurationDetailIsCleanedWhenConfigurationDeleted [
	| config |
	self setUpPresenter.
	config := image defaultLaunchConfiguration.

	presenter
		selectConfiguration: config;
		clickDeleteConfigurationButton.

	self assertEmpty: presenter imageArguments.
	self assertEmpty: presenter vmArguments.
	self assertEmpty: presenter configurationName
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testEditingAndSavingAConfigurationSelectsItInImagesPresenterToolbar [
	| config imagesPresenter |
	imagesPresenter := PhLTestImagesPresenter new.
	presenter application imagesPresenter: imagesPresenter.
	imagesPresenter 
		openWithSpec;
		selectImageAt: 1.
	image := imagesPresenter singleImage.
	config := (PhLLaunchConfiguration withImage: image)
				name: 'test config';
				yourself.
	image addLaunchConfiguration: config.
		
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
PhLLaunchConfigurationPresenterTest >> testImageInteractiveArgumentIsAddedWhenHeadlessVMSelectedAndArgumentNotAlreadyPresent [
	| headlessVm |
	headlessVm := presenter vmListItems anyOne beHeadless.
	
	presenter selectVm: headlessVm.
	
	self assert: (presenter imageArguments includes: '--interactive')
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testImageInteractiveArgumentIsNotAddedWhenHeadlessVMSelectedAndArgumentAlreadyPresent [
	| headlessVm |
	headlessVm := presenter vmListItems anyOne beHeadless.
	presenter imageArguments add: '--interactive'.
	
	presenter selectVm: headlessVm.
	
	self 
		assert: (presenter imageArguments select: [ :arg | arg = '--interactive' ]) size 
		equals: 1
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
PhLLaunchConfigurationPresenterTest >> testRemoveImageArgument [
	presenter imageArguments add: '--interactive'.
	self assert: presenter imageArguments size equals: 1.

	presenter selectImageArgumentAt: 1.
	presenter clickDeleteImageArgumentButton.

	self assertEmpty: presenter imageArguments
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testRemoveImageArgumentWithoutSelectionDoesNotThrowError [
	presenter imageArguments add: '--interactive'.

	"Unselect"
	presenter selectImageArgumentAt: 0.

	self shouldnt: [ presenter clickDeleteImageArgumentButton ] raise: NotFound
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testRemoveVMArgument [
	presenter vmArguments add: '--interactive'.
	self assert: presenter vmArguments size equals: 1.

	presenter selectVMArgumentAt: 1.
	presenter clickDeleteVMArgumentButton.

	self assertEmpty: presenter vmArguments
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testRemoveVMArgumentWithoutSelectionDoesNotThrowError [
	presenter vmArguments add: '--interactive'.

	"Unselect"
	presenter selectVMArgumentAt: 0.

	self shouldnt: [ presenter clickDeleteVMArgumentButton ] raise: NotFound
]

{ #category : #tests }
PhLLaunchConfigurationPresenterTest >> testSelectingAConfigurationAndClosingWindowSelectsItInImagesPresenterToolbar [
	| config imagesPresenter window |
	imagesPresenter := PhLTestImagesPresenter new.
	imagesPresenter selectImageAt: 1.
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
	
	window := presenter openWithSpec.		
	presenter selectConfiguration: config.
	window close.
	
	self 
		assert: imagesPresenter selectedLaunchConfiguration name
		equals: config name.
	imagesPresenter delete.
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
