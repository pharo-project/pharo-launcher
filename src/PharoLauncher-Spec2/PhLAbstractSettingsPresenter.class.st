"
I share common behviour common to presenters used to present Pharo Launcher settings.
"
Class {
	#name : 'PhLAbstractSettingsPresenter',
	#superclass : 'SpPresenterWithModel',
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'instance creation' }
PhLAbstractSettingsPresenter >> newNumberInputFor: aSettingName [
	| declaration |
	
	declaration := self settingNamed: aSettingName.
	^ self newNumberInput
		help: declaration description;
		beInteger;
		minimum: 0;
		number: (self valueOfSettingNamed: aSettingName);
		whenNumberChangedDo: [ :aNumber | self setValueOfSettingNamed: aSettingName with: aNumber ]
]

{ #category : 'instance creation' }
PhLAbstractSettingsPresenter >> newSwitchFor: aSettingName [
	| declaration |
	
	declaration := self settingNamed: aSettingName.
	^ self newSwitch
		help: declaration description;
		state: (self valueOfSettingNamed: aSettingName);
		whenChangedDo: [ :state | self setValueOfSettingNamed: aSettingName with: state ]
	
]

{ #category : 'instance creation' }
PhLAbstractSettingsPresenter >> newTextInputFor: aSettingName [
	| declaration |
	
	declaration := self settingNamed: aSettingName.
	^ self newTextInput
		help: declaration description;
		text: (self valueOfSettingNamed: aSettingName);
		whenTextChangedDo: [ :text | self setValueOfSettingNamed: aSettingName with: text ]
]

{ #category : 'accessing' }
PhLAbstractSettingsPresenter >> setValueOfSettingNamed: aSettingName with: aValue [
	
	^ self settings setValueOfSettingNamed: aSettingName with: aValue
]

{ #category : 'accessing' }
PhLAbstractSettingsPresenter >> settingNamed: aSettingName [
	
	^ self settings settingNamed: aSettingName
]

{ #category : 'accessing' }
PhLAbstractSettingsPresenter >> settings [

	^ self model
]

{ #category : 'accessing' }
PhLAbstractSettingsPresenter >> valueOfSettingNamed: aSettingName [
	
	^ self settings valueOfSettingNamed: aSettingName
]
