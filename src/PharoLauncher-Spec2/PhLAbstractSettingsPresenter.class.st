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
PhLAbstractSettingsPresenter >> newNumberInputFor: aSettingIdentifier [
	| declaration |
	
	declaration := self settings declarationNamed: aSettingIdentifier.
	^ self newNumberInput
		help: declaration description;
		beInteger;
		minimum: 0;
		number: (self settings valueOfDeclarationNamed: aSettingIdentifier);
		whenNumberChangedDo: [ :aNumber | self settings setValueOfDeclarationNamed: aSettingIdentifier with: aNumber ]
]

{ #category : 'instance creation' }
PhLAbstractSettingsPresenter >> newSwitchFor: aSettingIdentifier [
	| declaration |
	
	declaration := self settings declarationNamed: aSettingIdentifier.
	^ self newSwitch
		help: declaration description;
		state: (self settings valueOfDeclarationNamed: aSettingIdentifier);
		whenChangedDo: [ :state | self settings setValueOfDeclarationNamed: aSettingIdentifier with: state ]
	
]

{ #category : 'instance creation' }
PhLAbstractSettingsPresenter >> newTextInputFor: aSettingIdentifier [
	| declaration |
	
	declaration := self settings declarationNamed: aSettingIdentifier.
	^ self newTextInput
		help: declaration description;
		text: (self settings valueOfDeclarationNamed: aSettingIdentifier);
		whenTextChangedDo: [ :text | self settings setValueOfDeclarationNamed: aSettingIdentifier with: text ]
]

{ #category : 'accessing' }
PhLAbstractSettingsPresenter >> settings [

	^ self model
]
