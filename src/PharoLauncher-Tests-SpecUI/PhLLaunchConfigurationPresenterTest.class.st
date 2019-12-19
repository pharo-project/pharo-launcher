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
