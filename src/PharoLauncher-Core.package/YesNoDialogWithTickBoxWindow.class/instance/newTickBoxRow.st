instance creation
newTickBoxRow
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