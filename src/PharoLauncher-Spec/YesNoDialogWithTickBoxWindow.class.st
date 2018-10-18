"
Yes - No Dialog window with a tick box used to disable warnings by example.

self confirm: 'Is this widget fine?' label: 'Title'
"
Class {
	#name : #YesNoDialogWithTickBoxWindow,
	#superclass : #QuestionWithoutCancelDialogWindow,
	#category : 'PharoLauncher-Spec'
}

{ #category : #'ui requests' }
YesNoDialogWithTickBoxWindow class >> confirm: description label: title [
	^ (UIManager default modalMorph openModal: (
		(self newWithTheme: Smalltalk ui theme)
			textFont: Smalltalk ui theme textFont;
			title: title;
			text: description)) answer
]

{ #category : #accessing }
YesNoDialogWithTickBoxWindow >> checkBoxBallonText [
	^ PhLLaunchImageCommand archMismatchSettingDescription
]

{ #category : #accessing }
YesNoDialogWithTickBoxWindow >> checkBoxLabel [
	^ PhLLaunchImageCommand archMismatchSettingLabel
]

{ #category : #accessing }
YesNoDialogWithTickBoxWindow >> checkBoxSelector [
	^ #warnOnArchMismatch
]

{ #category : #accessing }
YesNoDialogWithTickBoxWindow >> checkBoxSetterSelector [
	^ #warnOnArchMismatch:
]

{ #category : #'instance creation' }
YesNoDialogWithTickBoxWindow >> newMainPanel [
	| panel |
	panel := super  newMainPanel.
	self newTickBoxRow ifNotNil: [:m | panel addMorphBack: m ].
	^ panel
]

{ #category : #'instance creation' }
YesNoDialogWithTickBoxWindow >> newTickBoxRow [
	"Answer a new tick box row."

	| row checkBox |
	checkBox := CheckboxMorph
		on: PhLLaunchImageCommand
		selected: self checkBoxSelector
		changeSelected: self checkBoxSetterSelector.
	checkBox
		label: self checkBoxLabel;
		vResizing: #shrinkWrap;
		hResizing: #shrinkWrap;
		setBalloonText: self checkBoxBallonText.
	row := Morph new
		color: Color transparent;
		changeTableLayout;
		cellInset: 8;
		listDirection: #rightToLeft;
		listCentering: #bottomRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
	row addMorphBack: checkBox.
	^ row
]
