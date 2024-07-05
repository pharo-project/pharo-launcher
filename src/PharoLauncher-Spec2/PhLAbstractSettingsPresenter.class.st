"
I share common behviour common to presenters used to present Pharo Launcher settings.
"
Class {
	#name : 'PhLAbstractSettingsPresenter',
	#superclass : 'SpPresenterWithModel',
	#category : 'PharoLauncher-Spec2',
	#package : 'PharoLauncher-Spec2'
}

{ #category : 'instance creation' }
PhLAbstractSettingsPresenter >> newCheckBoxFor: aSettingIdentifier [
	| declaration |
	
	declaration := self settings declarationNamed: aSettingIdentifier.
	^ self newCheckBox
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
		whenChangedDo: [ :text | self settings setValueOfDeclarationNamed: aSettingIdentifier with: text ]
]

{ #category : 'accessing' }
PhLAbstractSettingsPresenter >> settings [

	^ self model
]
