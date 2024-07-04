Class {
	#name : 'PhLSettingsPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'helpInput',
		'settingsPanel',
		'generalCategoryImagePresenter',
		'networkCategoryImagePresenter',
		'appearenceCategoryImagePresenter'
	],
	#category : 'PharoLauncher-Spec2',
	#package : 'PharoLauncher-Spec2'
}

{ #category : 'instance creation' }
PhLSettingsPresenter class >> open [

	<script>

	^ self new open
]

{ #category : 'accessing' }
PhLSettingsPresenter >> appearenceSettingsPanel [
	^ self instantiate: PhLAppearanceSettingsPresenter
]

{ #category : 'layout' }
PhLSettingsPresenter >> categoriesLayout [

	^ SpBoxLayout newTopToBottom 
		spacing: 30;
		hAlignCenter;
		add: (SpBoxLayout newTopToBottom 
			spacing: 5;
			hAlignCenter;
			add: generalCategoryImagePresenter;
			add: 'Pharo Launcher';
			yourself);
		add: (SpBoxLayout newTopToBottom 
			spacing: 5;
			hAlignCenter;
			add: appearenceCategoryImagePresenter;
			add: 'Appearance';
			yourself);
		add: (SpBoxLayout newTopToBottom 
			spacing: 5;
			hAlignCenter;
			add: networkCategoryImagePresenter;
			add: 'Network';
			yourself);
		yourself 
]

{ #category : 'layout' }
PhLSettingsPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight 
		spacing: 20;
		borderWidth: 5;
		add: self categoriesLayout expand: false;
		add: settingsPanel;
		yourself.
]

{ #category : 'accessing' }
PhLSettingsPresenter >> generalSettingsPanel [
	^ self instantiate: PhLGeneralSettingsPresenter on: self settings
]

{ #category : 'initialization' }
PhLSettingsPresenter >> initialExtent [

	^ 750@750
]

{ #category : 'initialization' }
PhLSettingsPresenter >> initializePresenters [

	self initializeSettingsCategories.
	settingsPanel := self generalSettingsPanel.
]

{ #category : 'initialization' }
PhLSettingsPresenter >> initializeSettingsCategories [

	generalCategoryImagePresenter := self newButton
		icon: (self iconNamed: #pharo);
		action: [ self updateSettingsPanelWith: self generalSettingsPanel ]
		yourself.
	networkCategoryImagePresenter := self newButton
		icon: (StSettingIcons networkingIcon);
		action: [ self updateSettingsPanelWith:self networkSettingsPanel ]
		yourself.
	appearenceCategoryImagePresenter := self newButton
		icon: (StSettingIcons appearanceIcon);
		action: [ self updateSettingsPanelWith: self appearenceSettingsPanel ]
		yourself.
]

{ #category : 'initialization' }
PhLSettingsPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Pharo Launcher settings'
]

{ #category : 'accessing' }
PhLSettingsPresenter >> networkSettingsPanel [
	^ self instantiate: PhLNetworkSettingsPresenter on: self settings
]

{ #category : 'accessing' }
PhLSettingsPresenter >> settings [

	^ self model
]

{ #category : 'accessing' }
PhLSettingsPresenter >> updateSettingsPanelWith: aPresenter [
	
	self layout replace: settingsPanel with: aPresenter.
	settingsPanel := aPresenter.
]
