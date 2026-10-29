Extension { #name : 'SpDialogWindowMorph' }

{ #category : '*PharoLauncher-SpecPatches-DialogCloseBox' }
SpDialogWindowMorph >> closeBoxHit [
	"Closing the dialog from its close box is a cancel, as when pressing escape"

	self allowedToClose ifFalse: [ ^ self ].
	self model triggerCancelAction
]

{ #category : '*PharoLauncher-SpecPatches-DialogCloseBox' }
SpDialogWindowMorph >> initializeLabelArea [
	"DialogWindowMorph removes all the boxes of the label area.
	 Keep a close box, as dialogs have in other backends (e.g. Gtk)"

	super initializeLabelArea.
	closeBox := self createCloseBox.
	self replaceBoxes
]
