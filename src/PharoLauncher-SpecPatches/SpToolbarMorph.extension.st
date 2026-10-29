Extension { #name : 'SpToolbarMorph' }

{ #category : '*PharoLauncher-SpecPatches-GridColumnSizing' }
SpToolbarMorph >> addItemCenter: aMorph [
	"Add aMorph centered in the space left between the left and right items."

	self
		addMorph: (self newPanelMorph
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			listCentering: #center;
			wrapCentering: #center;
			addMorphBack: (aMorph
				hResizing: #shrinkWrap;
				yourself);
			yourself)
		after: leftPanel.
	rightPanel hResizing: #shrinkWrap
]
