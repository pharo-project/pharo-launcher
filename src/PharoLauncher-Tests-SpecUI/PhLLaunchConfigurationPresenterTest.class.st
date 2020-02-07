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
	application := PhLTestApplication new.
	presenter := PhLLaunchConfigurationPresenter
		             newApplication: application
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
